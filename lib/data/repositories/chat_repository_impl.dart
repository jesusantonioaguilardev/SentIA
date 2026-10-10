import 'package:sentia2/domain/repositories/chat_repository.dart';
import 'package:sentia2/data/services/ai_service.dart';

class ChatRepositoryImpl implements ChatRepository {
  final AIService _aiService;

  const ChatRepositoryImpl(this._aiService);

  @override
  Future<String> getAIResponse(String prompt) async {
    try {
      return await _aiService.getResponse(prompt);
    } catch (e) {
      throw Exception('Error al obtener respuesta de la IA en la capa Data');
    }
  }
}
