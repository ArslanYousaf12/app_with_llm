import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class AppTheme {
  static ThemeData get themeData {
    return ThemeData(
      primaryColor: AppConstants.primary,
      scaffoldBackgroundColor: AppConstants.background,
      fontFamily: AppConstants.fontFamily,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppConstants.background,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontFamily: AppConstants.fontFamily,
          fontSize: AppConstants.headingSize,
          color: AppConstants.textLight,
        ),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: AppConstants.timerTextSize,
          fontWeight: FontWeight.bold,
          color: AppConstants.textDark,
          fontFamily: AppConstants.fontFamily,
        ),
        labelLarge: TextStyle(
          fontSize: AppConstants.buttonTextSize,
          fontWeight: FontWeight.w600,
          color: AppConstants.textLight,
          fontFamily: AppConstants.fontFamily,
        ),
      ),
    );
  }
}