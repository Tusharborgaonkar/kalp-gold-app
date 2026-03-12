import 'package:flutter/material.dart';

class AppColors {
  // Primary colors (Premium professional palette)
  static const Color primary = Color(0xFF4F46E5);
  static const Color primaryLight = Color(0xFF818CF8);
  static const Color primaryDark = Color(0xFF3730A3);

  // Background colors
  static const Color background = Color(0xFFF8FAFC);
  static const Color backgroundEnd = Color(0xFFF1F5F9);
  static const Color white = Colors.white;

  // Metal colors
  static const Color gold = Color(0xFFD4AF37);
  static const Color goldLight = Color(0xFFF6D365);
  static const Color silver = Color(0xFFA8A9AD);
  static const Color silverLight = Color(0xFFE2E8F0);

  // Text colors
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF64748B);

  // Status colors
  static const Color success = Color(0xFF16A34A);
  static const Color error = Color(0xFFDC2626);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryLight, primary],
  );

  static const LinearGradient goldGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [gold, goldLight],
  );

  static const LinearGradient silverGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF8E9196), Color(0xFFE2E8F0), Color(0xFF8E9196)],
  );

  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF4F46E5), Color(0xFF3730A3)],
  );

  static const LinearGradient actionGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF4F46E5), Color(0xFF818CF8)],
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
