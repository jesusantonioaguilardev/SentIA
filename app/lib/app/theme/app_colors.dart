import 'package:flutter/material.dart';

/// Paleta clara "Serena & Calma" — fuente de verdad: docs/design/DESIGN.md.
abstract final class AppColors {
  static const Color primary = Color(0xFF1E536F);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primaryContainer = Color(0xFF3A6B88);
  static const Color onPrimaryContainer = Color(0xFFCAE8FF);
  static const Color primaryFixed = Color(0xFFC6E7FF);
  static const Color inversePrimary = Color(0xFF9CCDED);

  static const Color secondary = Color(0xFF3D6847);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color secondaryContainer = Color(0xFFBCEBC2);
  static const Color onSecondaryContainer = Color(0xFF416C4B);

  static const Color tertiary = Color(0xFF58476A);
  static const Color onTertiary = Color(0xFFFFFFFF);
  static const Color tertiaryContainer = Color(0xFF705F83);
  static const Color onTertiaryContainer = Color(0xFFF0DEFF);
  static const Color tertiaryFixed = Color(0xFFEFDBFF);
  static const Color onTertiaryFixedVariant = Color(0xFF504062);

  static const Color error = Color(0xFFBA1A1A);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color errorContainer = Color(0xFFFFDAD6);
  static const Color onErrorContainer = Color(0xFF93000A);

  static const Color surface = Color(0xFFF3FBFF);
  static const Color surfaceDim = Color(0xFFD2DBE0);
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color surfaceContainerLow = Color(0xFFECF5FA);
  static const Color surfaceContainer = Color(0xFFE6EFF4);
  static const Color surfaceContainerHigh = Color(0xFFE0EAEF);
  static const Color surfaceContainerHighest = Color(0xFFDBE4E9);
  static const Color onSurface = Color(0xFF141D21);
  static const Color onSurfaceVariant = Color(0xFF41484D);
  static const Color inverseSurface = Color(0xFF293236);
  static const Color onInverseSurface = Color(0xFFE9F2F7);
  static const Color outline = Color(0xFF71787E);
  static const Color outlineVariant = Color(0xFFC1C7CE);

  /// Pizarra cálida para sombras y bordes finos (`rgba(44, 53, 57, …)`).
  static const Color slate = Color(0xFF2C3539);

  /// Acentos semánticos suaves.
  static const Color notice = Color(0xFFD98E52);
  static const Color sensitive = Color(0xFFC26767);
}

/// Paleta oscura. El diseño solo define el modo claro; esta deriva de
/// los mismos tonos con contraste AA. TODO(etapa-1): validar con diseño.
abstract final class AppColorsDark {
  static const Color primary = Color(0xFF9CCDED);
  static const Color onPrimary = Color(0xFF00344B);
  static const Color primaryContainer = Color(0xFF1E536F);
  static const Color onPrimaryContainer = Color(0xFFC6E7FF);
  static const Color primaryFixed = Color(0xFF144C67);

  static const Color secondary = Color(0xFFA3D2AA);
  static const Color onSecondary = Color(0xFF0B3818);
  static const Color secondaryContainer = Color(0xFF254F31);
  static const Color onSecondaryContainer = Color(0xFFBEEEC5);

  static const Color tertiary = Color(0xFFD4BEE8);
  static const Color onTertiary = Color(0xFF392A4B);
  static const Color tertiaryContainer = Color(0xFF504062);
  static const Color onTertiaryContainer = Color(0xFFEFDBFF);

  static const Color error = Color(0xFFFFB4AB);
  static const Color onError = Color(0xFF690005);
  static const Color errorContainer = Color(0xFF93000A);
  static const Color onErrorContainer = Color(0xFFFFDAD6);

  static const Color surface = Color(0xFF0F171A);
  static const Color surfaceContainerLowest = Color(0xFF0A1114);
  static const Color surfaceContainerLow = Color(0xFF172024);
  static const Color surfaceContainer = Color(0xFF1B2428);
  static const Color surfaceContainerHigh = Color(0xFF232E33);
  static const Color surfaceContainerHighest = Color(0xFF2C3539);
  static const Color onSurface = Color(0xFFE9F2F7);
  static const Color onSurfaceVariant = Color(0xFFC1C7CE);
  static const Color outline = Color(0xFF8B9BA3);
  static const Color outlineVariant = Color(0xFF41484D);
}
