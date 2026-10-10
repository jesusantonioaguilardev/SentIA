// TODO(etapa-2): la escala y la lista de emociones están [PENDIENTE] (docs/12);
// las etiquetas pasarán a ARB al reescribir el mood tracker.
enum MoodType {
  feliz('Feliz'),
  tranquilo('Tranquilo'),
  neutral('Neutral'),
  triste('Triste'),
  ansioso('Ansioso'),
  enojado('Enojado');

  new(this.label);

  final String label;
}

class MoodEntry {
  const new({
    required this.id,
    required this.mood,
    required this.timestamp,
    this.note,
  });

  final String id;
  final MoodType mood;
  final DateTime timestamp;
  final String? note;
}
