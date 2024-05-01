import 'package:flutter/material.dart';


class ThemeManager {
  static ThemeMode _currentThemeMode = ThemeMode.light;
  static ThemeMode get currentThemeMode => _currentThemeMode;

  static void toggleTheme(ThemeMode themeMode) {
    if (themeMode == ThemeMode.light) {
      _currentThemeMode = ThemeMode.light;
    } else {
      _currentThemeMode = ThemeMode.dark;
    }
  }
}

class AppThemes {

  static final appThemeData = {
    ThemeMode.light: ThemeData(

      scaffoldBackgroundColor: Colors.white,
     textTheme: const TextTheme(

        bodyLarge: TextStyle(
          color: Colors.black,
          fontSize: 20
        ),
        bodyMedium: TextStyle(
          color: Colors.black,
          fontSize: 14
        ),
        bodySmall: TextStyle(
          color: Colors.black,
          fontSize: 10
        ),
      ),
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.purple,
      ).copyWith(
        background: Colors.white,
      ),
    ),
    ThemeMode.dark: ThemeData(
      scaffoldBackgroundColor: Colors.black,
      textTheme: const TextTheme(
        bodyMedium: TextStyle(
          color: Colors.white,
        ),
      ),
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.teal,
      ).copyWith(
        background: Colors.black,
      ),
    )
  };
}


