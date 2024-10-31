import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ThemeProvider with ChangeNotifier {
  late ThemeMode _themeMode;

  ThemeProvider() {
    // Initialize with system theme by default
    final brightness =
        SchedulerBinding.instance.platformDispatcher.platformBrightness;
    _themeMode =
        brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light;
  }

  // Get current theme mode
  ThemeMode get themeMode => _themeMode;

  // Switch theme mode based on user choice
  void toggleTheme(bool isDarkMode) {
    _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  // Update theme mode based on system preference
  void updateThemeBasedOnSystem(Brightness brightness) {
    _themeMode =
        brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
