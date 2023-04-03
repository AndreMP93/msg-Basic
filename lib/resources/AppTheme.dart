import 'package:flutter/material.dart';
import 'AppColors.dart';

class AppTheme {
  static ThemeData get mainTheme {
    return ThemeData(
      primaryColor: AppColors.primaryColor,
      colorScheme: ColorScheme.fromSwatch(
          primarySwatch: AppColors.customPrimaySwatch,
      ),
      // scaffoldBackgroundColor: Colors.white,
    );
  }
}