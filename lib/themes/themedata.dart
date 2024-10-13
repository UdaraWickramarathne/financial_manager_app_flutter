import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey[300]!,
    ),
    colorScheme: ColorScheme.light(
      surface: Colors.grey[300]!,
      primary: Colors.grey[200]!,
      secondary: Colors.grey[300]!,
    ));

ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      surface: const Color.fromARGB(255, 22, 22, 22),
      primary: Colors.grey[900]!,
      secondary: Colors.grey[800]!,
    ));
