import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
    primaryColor: const Color(0x00f4f1f8),
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      surface: Colors.white,
      primary: Colors.grey.shade800,
      secondary: Colors.grey.shade200,
    ));

ThemeData darkMode = ThemeData(
    primaryColor: const Color(0x36363636),
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0x00a1a1a1),
    colorScheme: ColorScheme.dark(
      surface: Colors.grey.shade900,
      primary: Colors.grey.shade300,
      secondary: Colors.grey.shade800,
    ));
