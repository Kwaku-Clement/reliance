import 'package:flutter/material.dart';
import 'package:reliance/core/theme/ap_colors.dart';

class AppTextStyles {
  // Light Theme Text Styles
  static const TextStyle headlineLargeLight = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.textLight,
  );
  static const TextStyle headlineMediumLight = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textLight,
  );
  static const TextStyle headlineSmallLight = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.textLight,
  );
  static const TextStyle bodyLargeLight = TextStyle(
    fontSize: 16,
    color: AppColors.textLight,
  );
  static const TextStyle bodyMediumLight = TextStyle(
    fontSize: 14,
    color: AppColors.textLight,
  );
  static const TextStyle bodySmallLight = TextStyle(
    fontSize: 12,
    color: AppColors.textSecondaryLight,
  );
  static const TextStyle buttonLight = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
  static const TextStyle errorLight = TextStyle(
    fontSize: 14,
    color: AppColors.errorLight,
    fontWeight: FontWeight.w500,
  );

  // Dark Theme Text Styles
  static const TextStyle headlineLargeDark = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.textDark,
  );
  static const TextStyle headlineMediumDark = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textDark,
  );
  static const TextStyle headlineSmallDark = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.textDark,
  );
  static const TextStyle bodyLargeDark = TextStyle(
    fontSize: 16,
    color: AppColors.textDark,
  );
  static const TextStyle bodyMediumDark = TextStyle(
    fontSize: 14,
    color: AppColors.textDark,
  );
  static const TextStyle bodySmallDark = TextStyle(
    fontSize: 12,
    color: AppColors.textSecondaryDark,
  );
  static const TextStyle buttonDark = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
  static const TextStyle errorDark = TextStyle(
    fontSize: 14,
    color: AppColors.errorDark,
    fontWeight: FontWeight.w500,
  );
}
