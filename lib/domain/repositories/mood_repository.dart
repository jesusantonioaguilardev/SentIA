import '../entities/mood_entry.dart';

abstract class MoodRepository {
  Future<List<MoodEntry>> getMoodHistory();
  Future<void> saveMood(MoodEntry entry);
}
