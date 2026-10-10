import 'package:flutter/material.dart';

abstract class AppColors {
  // Light Palette (Fuente de verdad)
  static const Color primary = Color(0xFF1E536F);
  static const Color primaryContainer = Color(0xFF3A6B88);
  static const Color secondary = Color(0xFF3D6847);
  static const Color secondaryContainer = Color(0xFFBCEBC2);
  static const Color tertiary = Color(0xFF58476A);
  static const Color tertiaryContainer = Color(0xFF705F83);
  static const Color background = Color(0xFFF3FBFF);
  static const Color surface = Color(0xFFF3FBFF);
  static const Color onSurface = Color(0xFF141D21);
  static const Color onSurfaceVariant = Color(0xFF606E75);
  static const Color outline = Color(0xFF71787E);
  static const Color error = Color(0xFFBA1A1A);
  static const Color cardBackground = Colors.white;
}

abstract class AppColorsDark {
  // Dark Palette (Borrador derivado para Serena & Calma)
  static const Color primary = Color(0xFF9CCDED); // Aclarado para legibilidad
  static const Color primaryContainer = Color(0xFF1E536F);
  static const Color secondary = Color(0xFFA3D2AA); // Sage aclarado
  static const Color secondaryContainer = Color(0xFF3D6847);
  static const Color tertiary = Color(0xFFD4BEE8);
  static const Color tertiaryContainer = Color(0xFF58476A);
  static const Color background = Color(0xFF0F171A); // Gris azulado profundo
  static const Color surface = Color(0xFF1A2429); // Superficie ligeramente más clara que fondo
  static const Color onSurface = Color(0xFFE9F2F7); // Contraste AA
  static const Color onSurfaceVariant = Color(0xFFA1B0B8);
  static const Color outline = Color(0xFF8B9BA3);
  static const Color error = Color(0xFFFFB4AB);
  static const Color cardBackground = Color(0xFF232E33);
}
