import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  // Configuración de seguridad para fuentes: si falla la red, usa fuente de sistema
  static void configureFonts() {
    GoogleFonts.config.allowRuntimeFetching = true;
  }

  static ThemeData get light {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.light,
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      tertiary: AppColors.tertiary,
      surface: AppColors.surface,
      onSurface: AppColors.onSurface,
      onSurfaceVariant: AppColors.onSurfaceVariant,
      outline: AppColors.outline,
      error: AppColors.error,
    ).copyWith(
      surfaceContainerLowest: Colors.white,
      surfaceContainerLow: const Color(0xFFF3FBFF),
      surfaceContainerHighest: const Color(0xFFE0EAEF),
    );

    return _buildTheme(colorScheme);
  }

  static ThemeData get dark {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.dark,
      primary: AppColorsDark.primary,
      secondary: AppColorsDark.secondary,
      tertiary: AppColorsDark.tertiary,
      surface: AppColorsDark.surface,
      onSurface: AppColorsDark.onSurface,
      onSurfaceVariant: AppColorsDark.onSurfaceVariant,
      outline: AppColorsDark.outline,
      error: AppColorsDark.error,
    ).copyWith(
      surfaceContainerLowest: AppColorsDark.cardBackground,
      surfaceContainerLow: const Color(0xFF1A2429),
      surfaceContainerHighest: const Color(0xFF2C3539),
    );

    return _buildTheme(colorScheme);
  }

  static ThemeData _buildTheme(ColorScheme colorScheme) {
    // Obtenemos el textTheme base del SDK de Flutter para evitar conflictos con paquetes externos
    final bool isDark = colorScheme.brightness == Brightness.dark;
    final TextTheme baseTextTheme = isDark ? ThemeData.dark().textTheme : ThemeData.light().textTheme;

    return ThemeData(
      useMaterial3: true,
      brightness: colorScheme.brightness,
      colorScheme: colorScheme,
      textTheme: GoogleFonts.plusJakartaSansTextTheme(baseTextTheme),
      cardTheme: CardThemeData(
        color: colorScheme.surfaceContainerLowest,
        surfaceTintColor: Colors.transparent, 
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
          side: BorderSide(color: colorScheme.onSurface.withValues(alpha: 0.05), width: 1),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: colorScheme.onSurface.withValues(alpha: 0.08)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: colorScheme.primary, width: 1.5),
        ),
        hintStyle: TextStyle(color: colorScheme.onSurfaceVariant, fontSize: 15),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: isDark ? colorScheme.primaryContainer : Colors.white,
          textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: const StadiumBorder(),
          elevation: 0,
        ),
      ),
    );
  }

  static ThemeData get lightTheme => light;
  static ThemeData get darkTheme => dark;
}
