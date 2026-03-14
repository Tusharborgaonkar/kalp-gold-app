import 'package:flutter/material.dart';

class AppColors {
  // Primary colors (Classic Bullion Palette)
  static const Color primary = Color(0xFF1B2C4E); // Deep Navy Blue
  static const Color primaryLight = Color(0xFF2B3A5A);
  static const Color primaryDark = Color(0xFF0D1B35);

  // Background colors
  static const Color background = Color(0xFFEEEEEE); // Light Grey
  static const Color backgroundEnd = Color(0xFFE0E0E0);
  static const Color white = Colors.white;

  // Metal colors
  static const Color gold = Color(0xFFD4AF37); // Metallic Gold
  static const Color goldLight = Color(0xFFDAB951);
  static const Color silver = Color(0xFFB0B0B0); // Silver
  static const Color silverLight = Color(0xFFC0C0C0);

  // Text colors
  static const Color textPrimary = Color(0xFF111111);
  static const Color textSecondary = Color(0xFF555555);
  static const Color textLight = Colors.white;

  // Status/Action colors
  static const Color success = Color(0xFF28A745); // Green for active/up
  static const Color error = Color(0xFFDC3545); // Red for down/call

  // Gradients (Kept for compatibility if used elsewhere, but ideally avoid in classic UI)
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryLight, primary],
  );

  static const LinearGradient goldGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [gold, gold], // Flattened for classic look
  );

  static const LinearGradient silverGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [silver, silver], // Flattened for classic look
  );

  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, primaryDark],
  );

  static const LinearGradient actionGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [success, success], // Flattened
  );

  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [background, backgroundEnd],
  );
}

class AppSpacing {
  static const double xs = 4.0;
  static const double s = 8.0;
  static const double m = 16.0;
  static const double l = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
}

class AppStrings {
  static const String appName = 'Gold & Silver Trading';
  static const String home = 'Home';
  static const String trade = 'Trade';
  static const String orders = 'Orders';
  static const String profile = 'Profile';
}
