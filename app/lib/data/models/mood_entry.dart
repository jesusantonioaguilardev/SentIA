import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sentia2/domain/entities/mood_entry.dart';

part 'mood_entry.freezed.dart';
part 'mood_entry.g.dart';

@freezed
abstract class MoodEntryModel with _$MoodEntryModel {
  const MoodEntryModel._();

  const factory MoodEntryModel({
    required String id,
    required MoodType mood,
    required DateTime timestamp,
    String? note,
  }) = _MoodEntryModel;

  factory MoodEntryModel.fromJson(Map<String, dynamic> json) => _$MoodEntryModelFromJson(json);

  factory MoodEntryModel.fromEntity(MoodEntry entity) => MoodEntryModel(
        id: entity.id,
        mood: entity.mood,
        timestamp: entity.timestamp,
        note: entity.note,
      );

  MoodEntry toEntity() => MoodEntry(
        id: id,
        mood: mood,
        timestamp: timestamp,
        note: note,
      );
}
