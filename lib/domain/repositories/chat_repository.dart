import '../entities/chat_message.dart';

abstract class ChatRepository {
  Future<String> getAIResponse(String prompt);
}
