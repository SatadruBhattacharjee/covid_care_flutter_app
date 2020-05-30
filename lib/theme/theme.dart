import 'package:flutter/material.dart';
import 'colors.dart';

ThemeData buildAppTheme() {
  ThemeData base = ThemeData(
    primarySwatch: kDeepPurpleSwatch,
    buttonTheme: ButtonThemeData(
      buttonColor: kPrimaryColor500,
      textTheme: ButtonTextTheme.primary,
    ),
    textTheme: TextTheme(
      subtitle2: TextStyle(color: kHeadingTextColor),
      headline5: TextStyle(color: kHeadingTextColor),
      button: TextStyle(color: kButtonColor),
    ),
  );
  return base;
}
