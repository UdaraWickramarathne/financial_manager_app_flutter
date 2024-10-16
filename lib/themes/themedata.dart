import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  fontFamily: 'Poppins',
  brightness: Brightness.light,
  appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w600,
        color: Colors.black,
      )),
  colorScheme: ColorScheme.light(
    surface: Colors.white,
    primary: Colors.grey[200]!,
    secondary: Colors.grey[300]!,
  ),
);

ThemeData darkMode = ThemeData(
  fontFamily: 'Poppins',
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    surface: const Color.fromARGB(255, 22, 22, 22),
    primary: Colors.grey[900]!,
    secondary: Colors.grey[800]!,
  ),
  appBarTheme: const AppBarTheme(
      backgroundColor: Color.fromARGB(255, 22, 22, 22),
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w600,
        color: Colors.white,
      )),
);
