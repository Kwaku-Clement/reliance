import 'package:flutter/material.dart';

class AppColors {
  // Light Theme Colors
  static const Color primaryLight = Color(0xFF007BFF);
  static const Color accentLight = Color(0xFF0056B3);
  static const Color backgroundLight = Color(0xFFF8F9FA);
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color textLight = Color(0xFF212529);
  static const Color textSecondaryLight = Color(0xFF6C757D);
  static const Color errorLight = Color(0xFFDC3545);
  static const Color successLight = Color(0xFF28A745);
  static const Color warningLight = Color(0xFFFFA000);

  // Dark Theme Colors
  static const Color primaryDark = Color(0xFF0056B3);
  static const Color accentDark = Color(
    0xFF003D80,
  ); // Even Darker Reliance Blue
  static const Color backgroundDark = Color(0xFF212529);
  static const Color cardDark = Color(0xFF343A40);
  static const Color textDark = Color(0xFFF8F9FA);
  static const Color textSecondaryDark = Color(0xFFADB5BD);
  static const Color errorDark = Color(0xFFEF5350);
  static const Color successDark = Color(0xFF66BB6A);
  static const Color warningDark = Color(0xFFFFCA28);

  // Transaction Colors
  static const Color credit = successLight;
  static const Color debit = errorLight;
  static const Color creditDark = successDark;
  static const Color debitDark = errorDark;
}
