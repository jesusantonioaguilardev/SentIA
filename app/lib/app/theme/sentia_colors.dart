import 'package:flutter/material.dart';
import 'package:sentia2/app/theme/app_colors.dart';

/// Colores del diseño "Serena & Calma" que no existen en [ColorScheme].
/// Uso: `Theme.of(context).extension<SentiaColors>()!`.
@immutable
class SentiaColors extends ThemeExtension<SentiaColors> {
  const new({
    required this.privacyContainer,
    required this.onPrivacyContainer,
    required this.calmContainer,
    required this.onCalmContainer,
    required this.notice,
    required this.sensitive,
    required this.hairline,
    required this.ambientShadow,
  });

  static const light = SentiaColors(
    privacyContainer: Color(0x66EFDBFF), // tertiary-fixed al 40 %
    onPrivacyContainer: AppColors.onTertiaryFixedVariant,
    calmContainer: AppColors.secondaryContainer,
    onCalmContainer: AppColors.onSecondaryContainer,
    notice: AppColors.notice,
    sensitive: AppColors.sensitive,
    hairline: Color(0x0F2C3539), // rgba(44, 53, 57, 0.06)
    ambientShadow: Color(0x0D2C3539), // rgba(44, 53, 57, 0.05)
  );

  static const dark = SentiaColors(
    privacyContainer: AppColorsDark.tertiaryContainer,
    onPrivacyContainer: AppColorsDark.onTertiaryContainer,
    calmContainer: AppColorsDark.secondaryContainer,
    onCalmContainer: AppColorsDark.onSecondaryContainer,
    notice: Color(0xFFF0B07F),
    sensitive: Color(0xFFE59A9A),
    hairline: Color(0x1FE9F2F7),
    ambientShadow: Color(0x40000000),
  );

  /// Fondo y texto de insignias de privacidad ("Tu espacio personal y seguro").
  final Color privacyContainer;
  final Color onPrivacyContainer;

  /// Superficies de calma / refuerzo positivo (salvia).
  final Color calmContainer;
  final Color onCalmContainer;

  /// Avisos suaves (ámbar) y señales emocionales sensibles (rosa apagado).
  final Color notice;
  final Color sensitive;

  /// Borde finísimo de tarjetas y sombra ambiental.
  final Color hairline;
  final Color ambientShadow;

  @override
  SentiaColors copyWith({
    Color? privacyContainer,
    Color? onPrivacyContainer,
    Color? calmContainer,
    Color? onCalmContainer,
    Color? notice,
    Color? sensitive,
    Color? hairline,
    Color? ambientShadow,
  }) => SentiaColors(
    privacyContainer: privacyContainer ?? this.privacyContainer,
    onPrivacyContainer: onPrivacyContainer ?? this.onPrivacyContainer,
    calmContainer: calmContainer ?? this.calmContainer,
    onCalmContainer: onCalmContainer ?? this.onCalmContainer,
    notice: notice ?? this.notice,
    sensitive: sensitive ?? this.sensitive,
    hairline: hairline ?? this.hairline,
    ambientShadow: ambientShadow ?? this.ambientShadow,
  );

  @override
  SentiaColors lerp(SentiaColors? other, double t) {
    if (other == null) return this;
    return SentiaColors(
      privacyContainer: Color.lerp(
        privacyContainer,
        other.privacyContainer,
        t,
      )!,
      onPrivacyContainer: Color.lerp(
        onPrivacyContainer,
        other.onPrivacyContainer,
        t,
      )!,
      calmContainer: Color.lerp(calmContainer, other.calmContainer, t)!,
      onCalmContainer: Color.lerp(onCalmContainer, other.onCalmContainer, t)!,
      notice: Color.lerp(notice, other.notice, t)!,
      sensitive: Color.lerp(sensitive, other.sensitive, t)!,
      hairline: Color.lerp(hairline, other.hairline, t)!,
      ambientShadow: Color.lerp(ambientShadow, other.ambientShadow, t)!,
    );
  }
}

extension SentiaColorsX on BuildContext {
  /// Colores extra del sistema de diseño para el tema actual.
  SentiaColors get sentiaColors => Theme.of(this).extension<SentiaColors>()!;
}
