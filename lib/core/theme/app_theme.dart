import 'package:flutter/material.dart';

class AppTheme {
  // Brand colors
  static const Color primaryGreen = Color(0xFF1D6E01); // Blinkit Green
  static const Color darkBgStart = Color(
    0xFF15180D,
  ); // Top dark olive/gold glow
  static const Color darkBgEnd = Color(0xFF0F0F11); // Bottom dark gray/black

  // Card and item backgrounds (glassmorphic dark theme)
  static const Color cardBg = Color(0xFF3F3E43);
  static const Color cardBgSecondary = Color(0xFF212029);
  static const Color cardBorder = Color(0xFF434245);

  // Text colors
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xFFF0F0F0);
  static const Color textMuted = Color(0xFF6E6E73);

  // Gradient definitions
  static const Gradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [darkBgStart, darkBgEnd],
    stops: [0.0, 0.45],
  );

  static const Gradient walletGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFE2B71B), // Golden yellow
      Color(0xFFB58E00), // Darker yellow/gold
    ],
  );

  static const Gradient walletBackGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF6B8E23), // Olive green
      Color(0xFF3E5314), // Darker olive green
    ],
  );

  static ThemeData get darkTheme {
    return ThemeData.dark().copyWith(
      scaffoldBackgroundColor: darkBgEnd,
      primaryColor: primaryGreen,
      colorScheme: const ColorScheme.dark(
        primary: primaryGreen,
        surface: cardBg,
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: textPrimary,
          letterSpacing: 2.0,
        ),
        titleMedium: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        bodyMedium: TextStyle(fontSize: 13, color: textSecondary, height: 1.3),
      ),
    );
  }
}
