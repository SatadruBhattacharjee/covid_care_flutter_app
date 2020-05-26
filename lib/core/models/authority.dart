import 'package:covid_care_app/core/models/location_model.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class NorthEast {
  double latitude;
  double longitude;

  Location get location => Location(
      latitude: latitude,
      longitude: longitude,
      time: Jiffy().valueOf().toDouble());

  NorthEast({@required this.latitude, @required this.longitude});
}

class SouthWest {
  double latitude;
  double longitude;

  Location get location => Location(
      latitude: latitude,
      longitude: longitude,
      time: Jiffy().valueOf().toDouble());

  SouthWest({@required this.latitude, @required this.longitude});
}

class Bounds {
  NorthEast northEast;
  SouthWest southWest;

  Bounds({@required this.northEast, @required this.southWest});
}

class Authority {
  String name;
  String url;
  Bounds bounds;
  String infoWebSite;

  Authority(
      {@required this.name, @required this.url, this.bounds, this.infoWebSite});
}
