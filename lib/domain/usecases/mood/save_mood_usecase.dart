import 'package:sentia2/domain/entities/mood_entry.dart';
import 'package:sentia2/domain/repositories/mood_repository.dart';

class SaveMoodUseCase {
  final MoodRepository repository;

  SaveMoodUseCase(this.repository);

  Future<void> execute(MoodEntry entry) {
    return repository.saveMood(entry);
  }
}
