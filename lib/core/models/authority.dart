import 'package:flutter/material.dart';

class NorthEast {
  double latitude;
  double longitude;

  NorthEast({@required this.latitude, @required this.longitude});
}

class SouthWest {
  double latitude;
  double longitude;

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
