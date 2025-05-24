import 'package:flutter/material.dart';

class AppColors {
  // Light Theme Colors
  static const Color primaryLight = Color(0xFF007BFF); // Reliance Blue
  static const Color accentLight = Color(0xFF0056B3); // Darker Reliance Blue
  static const Color backgroundLight = Color(0xFFF8F9FA); // Off-white
  static const Color cardLight = Color(0xFFFFFFFF); // White
  static const Color textLight = Color(0xFF212529); // Dark Grey
  static const Color textSecondaryLight = Color(0xFF6C757D); // Medium Grey
  static const Color errorLight = Color(0xFFDC3545); // Red
  static const Color successLight = Color(0xFF28A745); // Green
  static const Color warningLight = Color(0xFFFFA000); // Amber

  // Dark Theme Colors
  static const Color primaryDark = Color(0xFF0056B3); // Darker Reliance Blue
  static const Color accentDark = Color(
    0xFF003D80,
  ); // Even Darker Reliance Blue
  static const Color backgroundDark = Color(0xFF212529); // Very Dark Grey
  static const Color cardDark = Color(0xFF343A40); // Darker Grey
  static const Color textDark = Color(0xFFF8F9FA); // Off-white
  static const Color textSecondaryDark = Color(0xFFADB5BD); // Lighter Grey
  static const Color errorDark = Color(0xFFEF5350); // Lighter Red
  static const Color successDark = Color(0xFF66BB6A); // Lighter Green
  static const Color warningDark = Color(0xFFFFCA28); // Lighter Amber

  // Transaction Colors
  static const Color credit = successLight;
  static const Color debit = errorLight;
  static const Color creditDark = successDark;
  static const Color debitDark = errorDark;
}
