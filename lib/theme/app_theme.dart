import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryBlue = Color(0xFF1DA1F2);
  static const Color backgroundColor = Colors.black;
  static const Color cardColor = Color(0xFF16181C);
  static const Color borderColor = Color(0xFF2F3336);
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xFF71767B);

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: backgroundColor,
    primaryColor: primaryBlue,
    colorScheme: const ColorScheme.dark(
      primary: primaryBlue,
      surface: backgroundColor,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: backgroundColor,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: textPrimary,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(color: textPrimary),
    ),
    dividerColor: borderColor,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: textPrimary),
      bodyMedium: TextStyle(color: textPrimary),
      bodySmall: TextStyle(color: textSecondary),
    ),
  );
}
