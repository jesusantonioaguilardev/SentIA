import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sentia2/features/chat/data/services/mock_ai_service.dart';

part 'ai_service.g.dart';

/// Fuente de respuestas del asistente. La implementación real llamará al
/// backend (`/v1/chat`), nunca a un proveedor de IA desde la app (docs/03).
abstract class AIService {
  Future<String> getResponse(String prompt);
  Stream<String> getResponseStream(String prompt);
}

// TODO(etapa-2): implementación contra el backend con streaming (docs/07).
@riverpod
AIService aiService(Ref ref) => MockAIService();
