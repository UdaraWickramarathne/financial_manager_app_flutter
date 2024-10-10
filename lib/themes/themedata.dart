import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
    primaryColor: const Color.fromRGBO(244, 241, 248, 1),
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color.fromRGBO(244, 241, 248, 1),
    colorScheme: ColorScheme.light(
      surface: Colors.white,
      primary: Colors.grey.shade800,
      secondary: Colors.grey.shade200,
    ));

ThemeData darkMode = ThemeData(
    primaryColor: const Color(0x12121212),
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color.fromRGBO(34, 35, 34, 1),
    colorScheme: ColorScheme.dark(
      surface: Colors.grey.shade900,
      primary: Colors.grey.shade300,
      secondary: Colors.grey.shade800,
    ));
