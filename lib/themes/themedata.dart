import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  fontFamily: 'Poppins',
  brightness: Brightness.light,
  datePickerTheme: const DatePickerThemeData(
    cancelButtonStyle: ButtonStyle(
      foregroundColor: WidgetStatePropertyAll(
        Colors.black,
      ),
    ),
    confirmButtonStyle: ButtonStyle(
      foregroundColor: WidgetStatePropertyAll(
        Colors.black,
      ),
    ),
  ),
  appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      titleTextStyle: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600,
        color: Colors.black,
      )),
  colorScheme: const ColorScheme.light(
    surface: Colors.white,
    primary: Color(0xFFf1f4ff),
    secondary: Colors.white,
  ),
  bottomAppBarTheme: BottomAppBarTheme(
    color: Colors.grey.shade200,
  ),
);

ThemeData darkMode = ThemeData(
  fontFamily: 'Poppins',
  brightness: Brightness.dark,
  datePickerTheme: const DatePickerThemeData(
    cancelButtonStyle: ButtonStyle(
      foregroundColor: WidgetStatePropertyAll(
        Colors.white,
      ),
    ),
    confirmButtonStyle: ButtonStyle(
      foregroundColor: WidgetStatePropertyAll(
        Colors.white,
      ),
    ),
  ),
  colorScheme: ColorScheme.dark(
    surface: const Color(0xFF111315),
    primary: const Color(0xFF292b2c),
    secondary: Colors.grey.shade800,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF111315),
    titleTextStyle: TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  ),
  bottomAppBarTheme: const BottomAppBarTheme(
    color: Color.fromARGB(255, 24, 26, 29),
  ),
);
