import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary Brand
  static const Color primary = Color(0xFF6B4EFF);
  static const Color primaryLight = Color(0xFF8B6FFF);
  static const Color primaryDark = Color(0xFF4B2EDF);
  static const Color primarySurface = Color(0xFFF0ECFF);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF9B85FF), Color(0xFF6B4EFF)],
  );
  static const Color gradientStart = Color(0xFF8C66FF);
  static const Color gradientEnd = Colors.white;


  static const LinearGradient onboardGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFB8A4FF), Color(0xFF7B5FFF)],
  );

  static const LinearGradient summaryCardGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0xFF7B5FFF), Color(0xFF9B85FF)],
  );

  // Status Colors
  static const Color accentRed = Color(0xFFFF4D4D);
  static const Color accentGreen = Color(0xFF4CAF50);
  static const Color accentOrange = Color(0xFFFF9800);
  static const Color highPriority = Color(0xFFFF4D4D);
  static const Color inProgressBg = Color(0xFFEEEBFF);

  // Backgrounds
  static const Color white = Color(0xFFFFFFFF);
  static const Color background = Color(0xFFF5F4FF);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color cardBg = Color(0xFFFFFFFF);
  static const Color darkBg = Color(0xFF1A1A2E);
  static const Color darkCard = Color(0xFF252540);

  // Text
  static const Color textPrimary = Color(0xFF1A1A2E);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textHint = Color(0xFFADB5BD);
  static const Color textOnPrimary = Color(0xFFFFFFFF);
  static const Color textPurple = Color(0xFF6B4EFF);
  static const Color error = Color(0xFFFF4D4D);

  // Borders & Dividers
  static const Color border = Color(0xFFE5E7EB);
  static const Color borderFocus = Color(0xFF6B4EFF);
  static const Color divider = Color(0xFFF0F0F5);

  // Bottom Nav
  static const Color bottomNavBg = Color(0xFF1A1A2E);
  static const Color bottomNavActive = Color(0xFFFFFFFF);
  static const Color bottomNavInactive = Color(0xFF6B7280);
}