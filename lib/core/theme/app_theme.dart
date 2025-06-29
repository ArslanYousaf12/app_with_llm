import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData.dark().copyWith(
      scaffoldBackgroundColor: AppConstants.backgroundDark,
      colorScheme: const ColorScheme.dark(
        primary: AppConstants.brightGreen,
        secondary: AppConstants.brightGreen,
        surface: AppConstants.darkGray,
        onPrimary: AppConstants.textDark,
        onSecondary: AppConstants.textDark,
        onSurface: AppConstants.textLight,
        background: AppConstants.backgroundDark,
        onBackground: AppConstants.textLight,
      ),
      useMaterial3: true,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppConstants.backgroundDark,
        foregroundColor: AppConstants.brightGreen,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: AppConstants.brightGreen,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppConstants.brightGreen,
          foregroundColor: AppConstants.textDark,
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(AppConstants.paddingLarge),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppConstants.brightGreen,
          side: const BorderSide(
            color: AppConstants.brightGreen,
            width: AppConstants.buttonBorderWidth,
          ),
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(AppConstants.paddingLarge),
        ),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: AppConstants.timerDisplayFontSize,
          fontWeight: FontWeight.bold,
          color: AppConstants.textDark,
          fontFamily: 'BebasNeue',
        ),
        titleLarge: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: AppConstants.brightGreen,
        ),
        bodyLarge: TextStyle(
          color: AppConstants.textLight,
        ),
        bodyMedium: TextStyle(
          color: AppConstants.textLight,
        ),
      ),
    );
  }
}