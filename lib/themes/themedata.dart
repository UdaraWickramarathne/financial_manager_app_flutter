import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
    primaryColor: Colors.white,
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      surface: Colors.white,
      primary: Colors.grey.shade800,
      secondary: Colors.grey.shade200,
    ));

ThemeData darkMode = ThemeData(
    primaryColor: Colors.grey.shade900,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      surface: Colors.grey.shade900,
      primary: Colors.grey.shade300,
      secondary: Colors.grey.shade800,
    ));
