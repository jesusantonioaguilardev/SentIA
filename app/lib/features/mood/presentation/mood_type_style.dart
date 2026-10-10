import 'package:flutter/material.dart';
import 'package:sentia2/features/mood/domain/entities/mood_entry.dart';

/// Ícono y colores de cada [MoodType]. Vive en presentación para que el
/// dominio no dependa de Flutter (docs/04).
extension MoodTypeStyle on MoodType {
  IconData get icon => switch (this) {
    MoodType.feliz => Icons.wb_sunny_outlined,
    MoodType.tranquilo => Icons.eco_outlined,
    MoodType.neutral => Icons.sentiment_neutral_outlined,
    MoodType.triste => Icons.water_drop_outlined,
    MoodType.ansioso => Icons.all_inclusive_rounded,
    MoodType.enojado => Icons.bolt_outlined,
  };

  Color get color => switch (this) {
    MoodType.feliz => const Color(0xFFD98E52),
    MoodType.tranquilo => const Color(0xFF3D6847),
    MoodType.neutral => const Color(0xFF606E75),
    MoodType.triste => const Color(0xFF3A6B88),
    MoodType.ansioso => const Color(0xFF7D6B90),
    MoodType.enojado => const Color(0xFFBA1A1A),
  };

  Color get backgroundColor => switch (this) {
    MoodType.feliz => const Color(0xFFFFF4D6),
    MoodType.tranquilo => const Color(0xFFBCEBC2),
    MoodType.neutral => const Color(0xFFF0EDF5),
    MoodType.triste => const Color(0xFFE8F1F5),
    MoodType.ansioso => const Color(0xFFF0DEFF),
    MoodType.enojado => const Color(0xFFFFDAD6),
  };
}
