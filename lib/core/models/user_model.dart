import 'dart:typed_data';

import 'package:flutter/material.dart';

class User {
  String name;
  String id;
  String photoUrl;

  Uint8List photo;

  User({@required this.id, this.name, this.photoUrl, this.photo});
}