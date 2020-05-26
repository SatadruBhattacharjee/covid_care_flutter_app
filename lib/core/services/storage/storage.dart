import 'dart:io';

import 'package:covid_care_app/core/models/location_model.dart';
import 'package:covid_care_app/core/models/user_model.dart';
import 'package:covid_care_app/core/services/storage/local_key_value_persistence.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import 'Repository.dart';

@lazySingleton
class Storage {
  String _deviceId;

  final LocalKeyValuePersistence _repository;

  // @factoryMethod
  // static Future<Storage> create({LocalKeyValuePersistence repository}) async {
  //   final ret = Storage(repository);
  //   return ret;
  // }

  Storage(this._repository);

  Future<dynamic> getStoreData(
      {@required String key, bool isString = true}) async {
    _deviceId = await deviceId();
    if (isString) {
      final value = await _repository.getString(_deviceId, key);
      return value;
    }
    final obj = await _repository.getObject(_deviceId, key);
    return obj;
  }

  Future<void> setStoreData(
      {@required String key,
      @required dynamic value,
      bool isString = true}) async {
    _deviceId = await deviceId();
    if (isString) {
      await _repository.saveString(_deviceId, key, value.toString());
    } else {
      await _repository.saveObject(_deviceId, key, value);
    }
  }

  Future<List<Location>> getLocations() async {}

  Future<String> deviceId() async {
    final DeviceInfoPlugin deviceInfo =DeviceInfoPlugin();
    var deviceId = '';
    if (Platform.isAndroid) {
      final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceId = await androidInfo.androidId;
    } else {
      final IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceId = await iosInfo.identifierForVendor;
    }

    return deviceId;
  }
}
