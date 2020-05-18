import 'package:flutter/material.dart';
import 'colors.dart';

ThemeData buildAppTheme() {
  ThemeData base = ThemeData(
    primarySwatch: kDeepPurpleSwatch,
    textTheme: TextTheme(
      subtitle2: TextStyle(color: Color(0xFF585858)),
      button: TextStyle(color: kButtonColor),
    ),
  );
  return base;
}
