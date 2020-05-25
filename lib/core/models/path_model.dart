import 'package:covid_care_app/core/models/location_model.dart';
import 'package:flutter/material.dart';

class Path {
  String origanizationName;
  String infoWebsite;
  double publishDate;
  List<Location> concernPoints;

  Path(
      {@required this.origanizationName,
      this.infoWebsite,
      this.publishDate,
      this.concernPoints});

  factory Path.fromJson(Map<String, dynamic> json) {
    return Path(
      origanizationName: json['authority_name'] as String,
      infoWebsite: json['info_website'] as String,
      publishDate: json['publish_date'] as double,
      concernPoints: (json['concern_points'] as List)
          .map((e) => Location.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
