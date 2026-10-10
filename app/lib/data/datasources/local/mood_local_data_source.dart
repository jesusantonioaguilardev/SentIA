import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/mood_entry.dart';

abstract class MoodLocalDataSource {
  Future<List<MoodEntryModel>> getLastMoodEntries();
  Future<void> cacheMoodEntry(MoodEntryModel entry);
}

class MoodLocalDataSourceImpl implements MoodLocalDataSource {
  final SharedPreferences sharedPreferences;
  static const CACHED_MOOD_ENTRIES = 'CACHED_MOOD_ENTRIES';

  MoodLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheMoodEntry(MoodEntryModel entry) async {
    final entries = await getLastMoodEntries();
    entries.insert(0, entry);
    final jsonList = entries.map((e) => e.toJson()).toList();
    await sharedPreferences.setString(CACHED_MOOD_ENTRIES, json.encode(jsonList));
  }

  @override
  Future<List<MoodEntryModel>> getLastMoodEntries() async {
    final jsonString = sharedPreferences.getString(CACHED_MOOD_ENTRIES);
    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.map((e) => MoodEntryModel.fromJson(e)).toList();
    } else {
      return [];
    }
  }
}
