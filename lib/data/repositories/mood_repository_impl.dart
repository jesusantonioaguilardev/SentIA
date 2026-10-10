import 'package:sentia2/domain/entities/mood_entry.dart';
import 'package:sentia2/domain/repositories/mood_repository.dart';
import 'package:sentia2/data/datasources/local/mood_local_data_source.dart';
import 'package:sentia2/data/models/mood_entry.dart';

class MoodRepositoryImpl implements MoodRepository {
  final MoodLocalDataSource localDataSource;

  MoodRepositoryImpl({required this.localDataSource});

  @override
  Future<List<MoodEntry>> getMoodHistory() async {
    final models = await localDataSource.getLastMoodEntries();
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<void> saveMood(MoodEntry entry) async {
    final model = MoodEntryModel.fromEntity(entry);
    await localDataSource.cacheMoodEntry(model);
  }
}
