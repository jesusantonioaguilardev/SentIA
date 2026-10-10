// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mood_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MoodEntryModelImpl _$$MoodEntryModelImplFromJson(Map<String, dynamic> json) =>
    _$MoodEntryModelImpl(
      id: json['id'] as String,
      mood: $enumDecode(_$MoodTypeEnumMap, json['mood']),
      timestamp: DateTime.parse(json['timestamp'] as String),
      note: json['note'] as String?,
    );

Map<String, dynamic> _$$MoodEntryModelImplToJson(
        _$MoodEntryModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'mood': _$MoodTypeEnumMap[instance.mood]!,
      'timestamp': instance.timestamp.toIso8601String(),
      'note': instance.note,
    };

const _$MoodTypeEnumMap = {
  MoodType.feliz: 'feliz',
  MoodType.tranquilo: 'tranquilo',
  MoodType.neutral: 'neutral',
  MoodType.triste: 'triste',
  MoodType.ansioso: 'ansioso',
  MoodType.enojado: 'enojado',
};
