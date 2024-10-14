import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      titleTextStyle: TextStyle(
        fontFamily: 'SofiaPro',
        fontWeight: FontWeight.w600,
        color: Colors.black,
      )),
  colorScheme: ColorScheme.light(
    surface: Colors.white,
    primary: Colors.grey[200]!,
    secondary: Colors.grey[300]!,
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(fontFamily: 'SofiaPro'),
    bodySmall: TextStyle(fontFamily: 'SofiaPro'),
    bodyLarge: TextStyle(fontFamily: 'SofiaPro'),
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    surface: const Color.fromARGB(255, 22, 22, 22),
    primary: Colors.grey[900]!,
    secondary: Colors.grey[800]!,
  ),
  appBarTheme: const AppBarTheme(
      backgroundColor: Color.fromARGB(255, 22, 22, 22),
      titleTextStyle: TextStyle(
        fontFamily: 'SofiaPro',
        fontWeight: FontWeight.w600,
        color: Colors.white,
      )),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(fontFamily: 'SofiaPro'),
    bodySmall: TextStyle(fontFamily: 'SofiaPro'),
    bodyLarge: TextStyle(fontFamily: 'SofiaPro'),
  ),
);
