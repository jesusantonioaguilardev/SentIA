import 'package:flutter/material.dart';

enum MoodType {
  feliz('Feliz', Icons.wb_sunny_outlined, Color(0xFFD98E52), Color(0xFFFFF4D6)),
  tranquilo('Tranquilo', Icons.eco_outlined, Color(0xFF3D6847), Color(0xFFBCEBC2)),
  neutral('Neutral', Icons.sentiment_neutral_outlined, Color(0xFF606E75), Color(0xFFF0EDF5)),
  triste('Triste', Icons.water_drop_outlined, Color(0xFF3A6B88), Color(0xFFE8F1F5)),
  ansioso('Ansioso', Icons.all_inclusive_rounded, Color(0xFF7D6B90), Color(0xFFF0DEFF)),
  enojado('Enojado', Icons.bolt_outlined, Color(0xFFBA1A1A), Color(0xFFFFDAD6));

  final String label;
  final IconData icon;
  final Color color;
  final Color backgroundColor;

  const MoodType(this.label, this.icon, this.color, this.backgroundColor);
}

class MoodEntry {
  final String id;
  final MoodType mood;
  final DateTime timestamp;
  final String? note;

  const MoodEntry({
    required this.id,
    required this.mood,
    required this.timestamp,
    this.note,
  });
}
