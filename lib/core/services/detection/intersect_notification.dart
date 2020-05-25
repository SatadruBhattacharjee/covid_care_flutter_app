import 'dart:convert';
import 'dart:math' as Math;
import 'package:covid_care_app/core/models/news_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:covid_care_app/core/constants/history_keys.dart';
import 'package:covid_care_app/core/constants/storage_keys.dart';
import 'package:covid_care_app/core/models/authority.dart';
import 'package:covid_care_app/core/models/location_model.dart';
import 'package:covid_care_app/core/models/path_model.dart';
import 'package:covid_care_app/core/services/storage/storage.dart';
import 'package:injectable/injectable.dart';
import 'package:jiffy/jiffy.dart';

@lazySingleton
class IntersectNotification {
  final Storage _storage;

  IntersectNotification(this._storage);

  /**
 * Intersects the locationArray with the concernLocationArray, returning the results
 *   as a dayBin array.
 *
 * @param {array} localArray - array of the local locations.  Assumed to have been sorted and normalized
 * @param {array} concernArray - superset array of all concerning points from health authorities.  Assumed to have been sorted and normalized
 * @param {int} numDayBins - (optional) number of bins in the array returned
 * @param {int} concernTimeWindowMS - (optional) window of time to use when determining an exposure
 * @param {int} defaultExposurePeriodMS - (optional) the default exposure period to use when necessary when an exposure is found
 */
  List<double> intersectSetIntoBins({
    List<Location> localArray,
    concernArray,
    numDayBins = HistoryKeys.MAX_EXPOSURE_WINDOW_DAYS,
    concernTimeWindowMS = 1000 * 60 * HistoryKeys.CONCERN_TIME_WINDOW_MINUTES,
    defaultExposurePeriodMS =
        HistoryKeys.DEFAULT_EXPOSURE_PERIOD_MINUTES * 60 * 1000,
  }) {
    // useful for time calcs
    //dayjs.extend(duration);

    // generate an array with the asked for number of day bins
    List<double> dayBins = getEmptyLocationBins(exposureWindowDays: numDayBins);

    //for (let loc of localArray) {
    for (int i = 0; i < localArray.length; i++) {
      Location currentLocation = localArray[i];

      // The current day is 0 days ago (in otherwords, bin 0).
      // Figure out how many days ago the current location was.
      // Note that we're basing this off midnight in the user's current timezone.
      // Also using the dayjs subtract method, which should take timezone and
      //   daylight savings into account.
      var midnight = Jiffy()..startOf(Units.DAY);
      int daysAgo = 0;
      while (
          currentLocation.time < midnight.valueOf() && daysAgo < numDayBins) {
        midnight = midnight..subtract(days: 1);
        daysAgo++;
      }

      // if this location's date is earlier than the number of days to bin, we can skip it
      if (daysAgo >= numDayBins) continue;

      // Check to see if this is the first exposure for this bin.  If so, reset the exposure time to 0
      // to indicate that we do actually have some data for this day
      if (dayBins[daysAgo] < 0) dayBins[daysAgo] = 0;

      // timeMin and timeMax set from the concern time window
      // These define the window of time that is considered an intersection of concern.
      // The idea is that if this location (lat,lon) is in the concernLocationArray from
      //   the time starting from this location's recorded minus the concernTimeWindow time up
      //   to this locations recorded time, then it is a location of concern.
      var timeMin = currentLocation.time - concernTimeWindowMS;
      var timeMax = currentLocation.time;

      // now find the index in the concernArray that starts with timeMin (if one exists)
      //
      // TODO:  There's probably an optimization that could be done if the locationArray
      //          increased in time only a small amount, since the index we found
      //          in the concernArray is probably already close to where we want to be.
      int j = binarySearchForTime(concernArray, timeMin);
      // we don't really if the exact timestamp wasn't found, so just take the j value as the index to start
      if (j < 0) j = -(j + 1);

      // starting at the now known index that corresponds to the beginning of the
      // location time window, go through all of the concernArray's time-locations
      // to see if there are actually any intersections of concern.  Stop when
      // we get past the timewindow.
      while (j < concernArray.length && concernArray[j].time <= timeMax) {
        if (areLocationsNearby(
          concernArray[j].latitude,
          concernArray[j].longitude,
          currentLocation.latitude,
          currentLocation.longitude,
        )) {
          // Crossed path.  Add the exposure time to the appropriate day bin.

          // How long was the possible concern time?
          //    = the amount of time from the current locations time to the next location time
          // or = if that calculated time is not possible or too large, use the defaultExposurePeriodMS
          var exposurePeriod = defaultExposurePeriodMS;
          if (i < localArray.length - 1) {
            var timeWindow = localArray[i + 1].time - currentLocation.time;
            if (timeWindow < defaultExposurePeriodMS * 2) {
              // not over 2x the default, so should be OK
              exposurePeriod = timeWindow;
            }
          }

          // now add the exposure period to the bin
          dayBins[daysAgo] += exposurePeriod;

          // Since we've counted the current location time period, we can now break the loop for
          // this time period and go on to the next location
          break;
        }

        j++;
      }
    }

    return dayBins;
  }

/**
 * Function to determine if two location points are "nearby".
 * Uses shortcuts when possible, then the exact calculation.
 *
 * @param {number} lat1 - location 1 latitude
 * @param {number} lon1 - location 1 longitude
 * @param {number} lat2 - location 2 latitude
 * @param {number} lon2 - location 2 longitude
 * @return {boolean} true if the two locations meet the criteria for nearby
 */
  bool areLocationsNearby(lat1, lon1, lat2, lon2) {
    int nearbyDistance = 20; // in meters, anything closer is "nearby"

    // these numbers from https://en.wikipedia.org/wiki/Decimal_degrees
    double notNearbyInLatitude = 0.00017966; // = nearbyDistance / 111320
    double notNearbyInLongitude_23Lat = 0.00019518; // = nearbyDistance / 102470
    double notNearbyInLongitude_45Lat = 0.0002541; // = nearbyDistance / 78710
    double notNearbyInLongitude_67Lat = 0.00045981; // = nearbyDistance / 43496

    double deltaLon = lon2 - lon1;

    // Initial checks we can do quickly.  The idea is to filter out any cases where the
    //   difference in latitude or the difference in longitude must be larger than the
    //   nearby distance, since this can be calculated trivially.
    if ((lat2 - lat1).abs() > notNearbyInLatitude) return false;
    if (lat1.abs() < 23) {
      if (deltaLon.abs() > notNearbyInLongitude_23Lat) return false;
    } else if (lat1.abs() < 45) {
      if (deltaLon.abs() > notNearbyInLongitude_45Lat) return false;
    } else if (lat1.abs() < 67) {
      if (deltaLon.abs() > notNearbyInLongitude_67Lat) return false;
    }

    // Close enough to do a detailed calculation.  Using the the Spherical Law of Cosines method.
    //    https://www.movable-type.co.uk/scripts/latlong.html
    //    https://en.wikipedia.org/wiki/Spherical_law_of_cosines
    //
    // Calculates the distance in meters
    double p1 = (lat1 * Math.pi) / 180;
    double p2 = (lat2 * Math.pi) / 180;
    double deltaLambda = (deltaLon * Math.pi) / 180;
    double R = 6371e3; // gives d in metres
    double d = Math.acos(
          Math.sin(p1) * Math.sin(p2) +
              Math.cos(p1) * Math.cos(p2) * Math.cos(deltaLambda),
        ) *
        R;

    // closer than the "nearby" distance?
    if (d < nearbyDistance) return true;

    // nope
    return false;
  }

/**
 * Performs "safety" cleanup of the data, to help ensure that we actually have location
 *   data in the array.  Also fixes cases with extra info or values coming in as strings.
 *
 * @param {array} arr - array of locations in JSON format
 */
  List<Location> normalizeAndSortLocations(List<Location> arr) {
    // This fixes several issues that I found in different input data:
    //   * Values stored as strings instead of numbers
    //   * Extra info in the input
    //   * Improperly sorted data (can happen after an Import)
    List<Location> result = [];

    if (arr != null) {
      for (int i = 0; i < arr.length; i++) {
        Location elem = arr[i];
        if (elem.time != null &&
            elem.latitude != null &&
            elem.longitude != null) {
          result.add(Location(
            time: elem.time,
            latitude: elem.latitude,
            longitude: elem.longitude,
          ));
        }
      }

      result.sort((a, b) => a.time.compareTo(b.time));
    }
    return result;
  }

// Basic binary search.  Assumes a sorted array.
  int binarySearchForTime(array, targetTime) {
    // Binary search:
    //   array = sorted array
    //   target = search target
    // Returns:
    //   value >= 0,   index of found item
    //   value < 0,    i where -(i+1) is the insertion point
    int i = 0;
    int n = array.length - 1;

    while (i <= n) {
      var k = (n + i) >> 1;
      var cmp = targetTime - array[k].time;

      if (cmp > 0) {
        i = k + 1;
      } else if (cmp < 0) {
        n = k - 1;
      } else {
        // Found exact match!
        // NOTE: Could be one of several if array has duplicates
        return k;
      }
    }
    return -i - 1;
  }

  /**
 * Async run of the intersection.  Also saves off the news sources that the authories specified,
 *    since that comes from the authorities in the same download.
 *
 * Returns the array of day bins (mostly for debugging purposes)
 */
  Future<List<double>> asyncCheckIntersect() async {
    // first things first ... is it time to actually try the intersection?
    double lastCheckedMs = double.parse(await _storage.getStoreData(
        key: StorageKeys.LAST_CHECKED, isString: true));
    if (lastCheckedMs + HistoryKeys.MIN_CHECK_INTERSECT_INTERVAL * 60 * 1000 >
        Jiffy().valueOf()) return null;

    // Set up the empty set of dayBins for intersections, and the array for the news urls
    List<double> dayBins = getEmptyLocationBins();
    List<News> nameNews = [];

    // get the saved set of locations for the user, already sorted
    List<Location> locationArray = await _storage.getLocations();

    // get the health authorities
    List<Authority> authority_list = await _storage.getStoreData(
        key: StorageKeys.AUTHORITY_SOURCE_SETTINGS, isString: false);

    if (authority_list != null) {
      // Parse the registered health authorities
      // authority_list = JSON.parse(authority_list);

      for (Authority authority in authority_list) {
        try {
          Path responseJson = await retrieveUrlAsJson(authority.url);

          // Update the news array with the info from the authority
          nameNews.add(News(
            authorityName: responseJson.origanizationName,
            infoWebSite: responseJson.infoWebsite,
          ));

          // intersect the users location with the locations from the authority
          List<double> tempDayBin = intersectSetIntoBins(
            localArray: locationArray,
            concernArray: normalizeAndSortLocations(responseJson.concernPoints),
          );

          // Update each day's bin with the result from the intersection.  To keep the
          //  difference between no data (==-1) and exposure data (>=0), there
          //  are a total of 3 cases to consider.
          dayBins = dayBins.asMap().entries.map((entry) {
            int i = entry.key;
            double currentValue = entry.value;

            if (currentValue < 0) return tempDayBin[i];
            if (tempDayBin[i] < 0) return currentValue;
            return currentValue + tempDayBin[i];
          }).toList();
        } catch (error) {
          // TODO: We silently fail.  Could be a JSON parsing issue, could be a network issue, etc.
          //       Should do better than this.
          print('[authority] fetch/parse error : $error');
        }
      }
    }

    // Store the news arary for the authorities found.
    await _storage.setStoreData(
        key: StorageKeys.AUTHORITY_NEWS, value: nameNews, isString: false);

    // if any of the bins are > 0, tell the user
    // if (dayBins.some(a => a > 0)) {
    //   notifyUserOfRisk();
    // }

    for (final dayBin in dayBins) {
      if (dayBin > 0) {
        notifyUserOfRisk();
        break;
      }
    }

    // store the results
    await _storage.setStoreData(
        key: StorageKeys.CROSSED_PATHS,
        value: dayBins,
        isString: false); // TODO: Store per authority?
    // await _storage.setStoreData(key : StorageKeys.AUTHORITY_NEWS, value: nameNews, isString: false);
    // save off the current time as the last checked time
    int unixtimeUTC = Jiffy().valueOf();
    await _storage.setStoreData(
        key: StorageKeys.LAST_CHECKED, value: unixtimeUTC, isString: false);

    return dayBins;
  }

  List<double> getEmptyLocationBins({
    exposureWindowDays = HistoryKeys.MAX_EXPOSURE_WINDOW_DAYS,
  }) {
    return List.filled(exposureWindowDays, -1);
  }

/**
 * Notify the user that they are possibly at risk
 */
  void notifyUserOfRisk() {
    // PushNotification.localNotification({
    //   title: languages.t('label.push_at_risk_title'),
    //   message: languages.t('label.push_at_risk_message'),
    // });
  }
/**
 * Return Json retrieved from a URL
 *
 * @param {*} url
 */
  Future<Path> retrieveUrlAsJson(@required url) async {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Path.fromJson(json.decode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

/** Set the app into debug mode */
  Future<void> enableDebugMode() async {
    await _storage.setStoreData(
        key: StorageKeys.DEBUG_MODE, value: 'true', isString: true);

    // Create faux intersection data
    List<double> pseudoBin = [];
    for (int i = 0; i < HistoryKeys.MAX_EXPOSURE_WINDOW_DAYS; i++) {
      double intersections =
          (Math.max(0, (Math.Random().nextInt(100) * 50 - 20)).floor() *
                  60 *
                  1000)
              .toDouble(); // in millis
      if (intersections == 0 && Math.Random().nextInt(100) < 0.3)
        intersections = -1; // about 30% of negative will be set as no data
      pseudoBin.add(intersections);
    }
    //let dayBin = JSON.stringify(pseudoBin);
    print(pseudoBin);
    //SetStoreData(CROSSED_PATHS, dayBin);
    await _storage.setStoreData(
        key: StorageKeys.CROSSED_PATHS, value: pseudoBin, isString: false);
  }

/** Restore the app from debug mode */
  Future<void> disableDebugMode() async {
    // Wipe faux intersection data
    List<double> pseudoBin = [];
    for (int i = 0; i < HistoryKeys.MAX_EXPOSURE_WINDOW_DAYS; i++) {
      pseudoBin.add(0);
    }
    //let dayBin = JSON.stringify(pseudoBin);
    //SetStoreData(CROSSED_PATHS, dayBin);
    await _storage.setStoreData(
        key: StorageKeys.CROSSED_PATHS, value: pseudoBin, isString: false);

    //SetStoreData(DEBUG_MODE, 'false');
    await _storage.setStoreData(
        key: StorageKeys.DEBUG_MODE, value: 'false', isString: true);

    // Kick off intersection calculations to restore data
    await asyncCheckIntersect();
  }
}
