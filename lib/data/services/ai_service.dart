import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sentia2/data/services/ai_service_impl.dart';



part 'ai_service.g.dart';

abstract class AIService {
  Future<String> getResponse(String prompt);
  Stream<String> getResponseStream(String prompt);
}

@riverpod
MockAIService aiService(AiServiceRef  ref) {
  return MockAIService();
}
