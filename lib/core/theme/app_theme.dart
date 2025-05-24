import 'package:flutter/material.dart';
import 'package:reliance/core/theme/ap_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primaryLight,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primaryLight,
      secondary: AppColors.accentLight,
      background: AppColors.backgroundLight,
      surface: AppColors.cardLight,
      error: AppColors.errorLight,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onBackground: AppColors.textLight,
      onSurface: AppColors.textLight,
      onError: Colors.white,
    ),
    scaffoldBackgroundColor: AppColors.backgroundLight,
    cardColor: AppColors.cardLight,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primaryLight,
      foregroundColor: Colors.white,
      elevation: 0,
      titleTextStyle: AppTextStyles.headlineMediumLight.copyWith(
        color: Colors.white,
      ),
    ),
    textTheme: const TextTheme(
      displayLarge: AppTextStyles.headlineLargeLight,
      displayMedium: AppTextStyles.headlineMediumLight,
      displaySmall: AppTextStyles.headlineSmallLight,
      headlineLarge: AppTextStyles.headlineLargeLight,
      headlineMedium: AppTextStyles.headlineMediumLight,
      headlineSmall: AppTextStyles.headlineSmallLight,
      bodyLarge: AppTextStyles.bodyLargeLight,
      bodyMedium: AppTextStyles.bodyMediumLight,
      bodySmall: AppTextStyles.bodySmallLight,
      labelLarge: AppTextStyles.buttonLight, // Used for button text
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryLight,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        textStyle: AppTextStyles.buttonLight,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      filled: true,
      fillColor: AppColors.cardLight,
      labelStyle: AppTextStyles.bodyMediumLight.copyWith(
        color: AppColors.textSecondaryLight,
      ),
      hintStyle: AppTextStyles.bodySmallLight,
      prefixIconColor: AppColors.textSecondaryLight,
    ),
    cardTheme: CardThemeData(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    // Add other theme properties as needed
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primaryDark,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primaryDark,
      secondary: AppColors.accentDark,
      background: AppColors.backgroundDark,
      surface: AppColors.cardDark,
      error: AppColors.errorDark,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onBackground: AppColors.textDark,
      onSurface: AppColors.textDark,
      onError: Colors.white,
    ),
    scaffoldBackgroundColor: AppColors.backgroundDark,
    cardColor: AppColors.cardDark,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primaryDark,
      foregroundColor: Colors.white,
      elevation: 0,
      titleTextStyle: AppTextStyles.headlineMediumDark.copyWith(
        color: Colors.white,
      ),
    ),
    textTheme: const TextTheme(
      displayLarge: AppTextStyles.headlineLargeDark,
      displayMedium: AppTextStyles.headlineMediumDark,
      displaySmall: AppTextStyles.headlineSmallDark,
      headlineLarge: AppTextStyles.headlineLargeDark,
      headlineMedium: AppTextStyles.headlineMediumDark,
      headlineSmall: AppTextStyles.headlineSmallDark,
      bodyLarge: AppTextStyles.bodyLargeDark,
      bodyMedium: AppTextStyles.bodyMediumDark,
      bodySmall: AppTextStyles.bodySmallDark,
      labelLarge: AppTextStyles.buttonDark,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryDark,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        textStyle: AppTextStyles.buttonDark,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      filled: true,
      fillColor: AppColors.cardDark,
      labelStyle: AppTextStyles.bodyMediumDark.copyWith(
        color: AppColors.textSecondaryDark,
      ),
      hintStyle: AppTextStyles.bodySmallDark,
      prefixIconColor: AppColors.textSecondaryDark,
    ),
    cardTheme: CardThemeData(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    // Add other theme properties as needed
  );
}
