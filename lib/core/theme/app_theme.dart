import 'package:flutter/material.dart';

class SentiaTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: const Color(0xFFF7F5F1),
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF7EA89B),
      brightness: Brightness.light,
      primary: const Color(0xFF7EA89B),
      secondary: const Color(0xFFDECDBA),
      tertiary: const Color(0xFFE2A9A2),
      surface: const Color(0xFFFDFBF7),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFF7F5F1),
      foregroundColor: Color(0xFF1F2D2A),
      elevation: 0,
    ),
    cardTheme: CardThemeData(
      color: const Color(0xFFFDFBF7),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: Color(0xFF1F2D2A),
      ),
      headlineMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: Color(0xFF1F2D2A),
      ),
      bodyLarge: TextStyle(fontSize: 18, color: Color(0xFF354743)),
      bodyMedium: TextStyle(fontSize: 16, color: Color(0xFF4A5E5B)),
    ),
  );
}
