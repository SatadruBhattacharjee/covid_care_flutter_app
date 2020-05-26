import 'dart:math' as Math;

import 'package:covid_care_app/core/models/authority.dart';
import 'package:covid_care_app/core/models/location_model.dart';

class LocationData {
  // The desired location interval, and the minimum acceptable interval
  final int locationInterval;
  // minLocationSaveInterval should be shorter than the locationInterval (to avoid strange skips)
  final int minLocationSaveInterval;
  // Maximum time that we will backfill for missing data
  final int maxBackfillTime;

  LocationData(
      {this.locationInterval = 60000 * 5,
      this.maxBackfillTime = 60000 * 60 * 24})
      : minLocationSaveInterval = (locationInterval * 0.8).floor();

  Future<List<Location>> getLocationData() async {}

  /**
   * Validates that `point` has both a latitude and longitude field
   * @param {*} point - Object to validate
   */
  bool isValidPoint(Location point) {
    if (point.latitude != null && point.latitude != 0) {
      print('`point` param must have a latitude field');
      return false;
    }

    if (point.longitude != null && point.longitude != 0) {
      print('`point` param must have a longitude field');
      return false;
    }

    return true;
  }

  /**
   * Validates that an object is a valid geographic bounding box.
   * A valid box has a `ne` and `sw` field that each contain a valid GPS point
   * @param {*} region - Object to validate
   */
  bool isValidBoundingBox(Bounds region) {
    if (region.northEast != null || !this.isValidPoint(region.northEast.location)) {
      print('invalid "ne" field for bounding box: ${region.northEast}');
      return false;
    }

    if (region.southWest != null || !this.isValidPoint(region.southWest.location)) {
      print('invalid "sw" field for bounding box: ${region.southWest}');
      return false;
    }

    return true;
  }

  /**
   * Returns the most recent point of location data for a user.
   * This is the last item in the location data array.
   */
  Future<Location> getMostRecentUserLoc() async {
    List<Location> locData = await getLocationData();
    return locData[locData.length - 1];
  }

  /**
   * Given a GPS coordinate, check if it is within the bounding
   * box of a region.
   * @param {*} point - Object with a `latitude` and `longitude` field
   * @param {*} region - Object with a `ne` and `sw` field that each contain a GPS point
   */
  bool isPointInBoundingBox(Location point, Bounds region) {
    if (!this.isValidPoint(point) || !this.isValidBoundingBox(region)) {
      return false;
    } else {
      //const { latitude: pointLat, longitude: pointLon } = point;
      double pointLat = point.latitude;
      double pointLon = point.longitude;

      //const { latitude: neLat, longitude: neLon } = region.ne;
      double neLat = region.northEast.location.latitude;
      double neLon = region.northEast.location.longitude;
      //const { latitude: swLat, longitude: swLon } = region.sw;
      double swLat = region.southWest.location.latitude;
      double swLon = region.southWest.location.longitude;

      //const [latMax, latMin] = neLat > swLat ? [neLat, swLat] : [swLat, neLat];
      var lat = neLat > swLat ? {'latMax': neLat, 'latMin': swLat} : {'latMax': swLat, 'latMin': neLat};
      //const [lonMax, lonMin] = neLon > swLon ? [neLon, swLon] : [swLon, neLon];
      var lon = neLon > swLon ? {'lonMax' : neLon, 'lonMin': swLon} : {'lonMax': swLon, 'lonMin': neLon};

      return (
        pointLat < lat['latMax'] &&
        pointLat > lat['latMin'] &&
        pointLon < lon['lonMax'] &&
        pointLon > lon['lonMin']
      );
    }
  }
}
