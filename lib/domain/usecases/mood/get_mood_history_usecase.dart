import 'package:sentia2/domain/entities/mood_entry.dart';
import 'package:sentia2/domain/repositories/mood_repository.dart';

class GetMoodHistoryUseCase {
  final MoodRepository repository;

  GetMoodHistoryUseCase(this.repository);

  Future<List<MoodEntry>> execute() {
    return repository.getMoodHistory();
  }
}
