import 'package:sentia2/domain/repositories/chat_repository.dart';

class GetAIResponseUseCase {
  final ChatRepository repository;

  GetAIResponseUseCase(this.repository);

  Future<String> execute(String prompt) {
    return repository.getAIResponse(prompt);
  }
}
