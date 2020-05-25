import 'package:flutter/material.dart';

class Location {
  double latitude;
  double longitude;
  double altitude;
  double bearing;
  double accuracy;
  double speed;
  double time;

  Location(
      {@required this.latitude,
      @required this.longitude,
      @required this.time,
      this.altitude,
      this.bearing,
      this.accuracy,
      this.speed});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      latitude: json['latitude'] as double,
      longitude: json['longitude']  as double,
      time: json['title']  as double,
    );
  }
}
