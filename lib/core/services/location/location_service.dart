import 'dart:isolate';
import 'dart:ui';

import 'package:background_locator/background_locator.dart';
import 'package:background_locator/location_dto.dart';
import 'package:background_locator/location_settings.dart';
import 'package:covid_care_app/core/constants/values.dart';
import 'package:location_permissions/location_permissions.dart';

class LocationService {
  static void notificationCallback() {
    print('notificationCallback');
  }

  static void callback(LocationDto locationDto) async {
    print('location in dart: ${locationDto.toString()}');

    // await setLog(locationDto);
    final SendPort send = IsolateNameServer.lookupPortByName(Values.ISOLATE_LOCATOR_NAME);
    send?.send(locationDto);
  }

  static Future<bool> checkLocationPermission() async {
    final access = await LocationPermissions().checkPermissionStatus();
    switch (access) {
      case PermissionStatus.unknown:
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
        final permission = await LocationPermissions().requestPermissions(
          permissionLevel: LocationPermissionLevel.locationAlways,
        );
        if (permission == PermissionStatus.granted) {
          start();
          return true;
        } else {
          // show error
          return false;
        }
        break;
      case PermissionStatus.granted:
        start();
        return true;
        break;
    }

    return false;
  }

  static Future initialize() async {
    await BackgroundLocator.initialize();
  }

  static void start() {
    BackgroundLocator.registerLocationUpdate(
      callback,
      androidNotificationCallback: notificationCallback,
      settings: LocationSettings(
          notificationTitle: "Start Location Tracking example",
          notificationMsg: "Track location in background exapmle",
          wakeLockTime: 20,
          autoStop: false,
          interval: 5),
    );
  }

  static void stop() {
    BackgroundLocator.unRegisterLocationUpdate();
  }

  static Future<bool> isRunning() async {
    final _isRunning = await BackgroundLocator.isRegisterLocationUpdate();
    return _isRunning;
  }
}
