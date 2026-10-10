import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sentia2/features/mood/domain/entities/mood_entry.dart';
import 'package:uuid/uuid.dart';

part 'mood_controller.g.dart';

@riverpod
class MoodEntries extends _$MoodEntries {
  @override
  List<MoodEntry> build() => [];

  void addMood(MoodType mood, {String? note}) {
    final entry = MoodEntry(
      id: const Uuid().v4(),
      mood: mood,
      timestamp: DateTime.now(),
      note: note,
    );
    state = [entry, ...state];
  }
}
