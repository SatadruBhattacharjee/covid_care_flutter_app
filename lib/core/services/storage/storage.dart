import 'dart:io';

import 'package:covid_care_app/core/models/location_model.dart';
import 'package:covid_care_app/core/models/user_model.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import 'Repository.dart';

@lazySingleton
class Storage {
  User _user;
  String _deviceId;

  set user(User user) {
    _user = user;
  }

  final IRepository _repository;

  @factoryMethod
  static Future<Storage> create({IRepository repository}) async {
    final ret = Storage(repository);
    ret.user = await ret.getUser();

    return ret;
  }

  User get user => _user;

  Storage(this._repository, [User user]) {
    _user = user;
  }

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
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
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

  void saveUser(User user) async {
    _deviceId = await deviceId();

    final photoLocation =
        await _repository.saveImage(_deviceId, 'avatar.jpg', user.photo);
    user.photoUrl = photoLocation;

    await _repository.saveString(_deviceId, 'user.name', user.name);
    await _repository.saveString(_deviceId, 'user.id', user.id);
    await _repository.saveString(_deviceId, 'user.photoUrl', user.photoUrl);

    _user = user;
  }

  Future<User> getUser() async {
    _deviceId = await deviceId();

    final name = await _repository.getString(_deviceId, 'user.name');
    final id = await _repository.getString(_deviceId, 'user.id');
    final url = await _repository.getString(_deviceId, 'user.photoUrl');
    final photo = await _repository.getImage(_deviceId, 'avatar.jpg');

    if (name == null) {
      return null;
    }

    final user = User(name: name, id: id, photoUrl: url, photo: photo);

    return user;
  }

  void logout() async {
    _deviceId = await deviceId();

    await _repository.removeImage(_deviceId, 'avatar.jpg');
    await _repository.removeString(_deviceId, 'user.name');
    await _repository.removeString(_deviceId, 'user.id');
    await _repository.removeString(_deviceId, 'user.photoUrl');

    _user = null;
  }

  void _saveCart() async {
    //await _repository.saveObject(_user.id, 'cart', _cart.toMap());
  }
}
