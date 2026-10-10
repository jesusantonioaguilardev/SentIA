import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sentia2/domain/repositories/auth_repository.dart';
import 'package:sentia2/domain/repositories/chat_repository.dart';
import 'package:sentia2/domain/repositories/mood_repository.dart';
import 'package:sentia2/data/repositories/chat_repository_impl.dart';
import 'package:sentia2/data/repositories/mood_repository_impl.dart';
import 'package:sentia2/data/services/ai_service.dart';
import 'package:sentia2/data/repositories/auth_repository_impl.dart';

part 'repository_providers.g.dart';

@riverpod
Future<SharedPreferences> sharedPreferences(Ref ref) {
  return SharedPreferences.getInstance();
}

@riverpod
ChatRepository chatRepository(Ref ref) {
  final aiService = ref.watch(aiServiceProvider);
  return ChatRepositoryImpl(aiService);
}

@riverpod
MoodRepository moodRepository(Ref ref) {
  // Nota: Implementación pendiente de inyectar SharedPreferences de forma síncrona
  throw UnimplementedError('MoodRepository necesita configuración de data sources');
}

@riverpod
AuthRepository authRepository(Ref ref) {
  // Retornamos el Mock por ahora para permitir que la app corra.
  // Cambiar por FirebaseAuthRepository o SupabaseAuthRepository cuando se decida.
  return MockAuthRepository();
}
