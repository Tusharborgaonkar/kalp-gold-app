import 'package:flutter/material.dart';

class AppColors {
  // Primary colors (Premium Purple/Indigo)
  static const Color primary = Color(0xFF6C63FF);
  static const Color primaryLight = Color(0xFF9D8CF6);
  static const Color primaryDark = Color(0xFF4834D4);

  // Background colors
  static const Color background = Color(0xFFF8F9FF);
  static const Color backgroundEnd = Color(0xFFEEF1FF);
  static const Color white = Colors.white;

  // Metal colors
  static const Color gold = Color(0xFFD4AF37);
  static const Color goldLight = Color(0xFFF6D365);
  static const Color silver = Color(0xFFA8A9AD);
  static const Color silverLight = Color(0xFFE5E7EB);

  // Text colors
  static const Color textPrimary = Color(0xFF1C1C1E);
  static const Color textSecondary = Color(0xFF8B8B9E);

  // Status colors
  static const Color success = Color(0xFF16C784);
  static const Color error = Color(0xFFEA3943);

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
    colors: [Color(0xFF8E9196), Color(0xFFE5E7EB), Color(0xFF8E9196)],
  );

  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF6C63FF), Color(0xFF4834D4)],
  );

  static const LinearGradient actionGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF6C63FF), Color(0xFF9D8CF6)],
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
