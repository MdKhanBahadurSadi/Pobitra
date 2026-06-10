import 'package:flutter/material.dart';

class AppTheme {
  // Common Colors
  static const Color primaryAccent = Color(0xFF0A84FF);

  // Light Mode Colors
  static const Color lightBackground = Color(0xFFF5F5F7);
  static const Color lightBorder = Color(0xFFD1D1D6);
  static const Color lightText = Color(0xFF1C1C1E);

  // Dark Mode Colors
  static const Color darkBackground = Color(0xFF1C1C1E);
  static const Color darkDivider = Color(0xFF38383A);
  static const Color darkText = Color(0xFFE5E5EA);

  // AMOLED Black Mode Colors
  static const Color amoledBackground = Color(0xFF000000);
  static const Color amoledBorder = Color(0xFF2C2C2E);
  static const Color amoledText = Color(0xFFFFFFFF);

  /// Standard Light Theme
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: primaryAccent,
      scaffoldBackgroundColor: lightBackground,
      dividerColor: lightBorder,
      colorScheme: const ColorScheme.light(
        primary: primaryAccent,
        surface: lightBackground,
        outline: lightBorder,
        onSurface: lightText,
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: lightText),
        bodyMedium: TextStyle(color: lightText),
        titleLarge: TextStyle(color: lightText, fontWeight: FontWeight.bold),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: lightBackground,
        foregroundColor: lightText,
        elevation: 0,
      ),
    );
  }

  /// Standard Dark Theme
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: primaryAccent,
      scaffoldBackgroundColor: darkBackground,
      dividerColor: darkDivider,
      colorScheme: const ColorScheme.dark(
        primary: primaryAccent,
        surface: darkBackground,
        outline: darkDivider,
        onSurface: darkText,
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: darkText),
        bodyMedium: TextStyle(color: darkText),
        titleLarge: TextStyle(color: darkText, fontWeight: FontWeight.bold),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: darkBackground,
        foregroundColor: darkText,
        elevation: 0,
      ),
    );
  }

  /// AMOLED Black Theme
  static ThemeData get amoledTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: primaryAccent,
      scaffoldBackgroundColor: amoledBackground,
      dividerColor: amoledBorder,
      colorScheme: const ColorScheme.dark(
        primary: primaryAccent,
        surface: amoledBackground,
        outline: amoledBorder,
        onSurface: amoledText,
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: amoledText),
        bodyMedium: TextStyle(color: amoledText),
        titleLarge: TextStyle(color: amoledText, fontWeight: FontWeight.bold),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: amoledBackground,
        foregroundColor: amoledText,
        elevation: 0,
      ),
    );
  }
}
