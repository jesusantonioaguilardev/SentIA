import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import 'package:sentia2/core/utils/risk_signal_detector.dart';
import 'package:sentia2/data/services/ai_service.dart';
import 'package:sentia2/domain/entities/chat_message.dart';

part 'chat_provider.g.dart';

class ChatUiState {
  final List<ChatMessage> messages;
  final bool isTyping;
  final String? errorMessage;
  final bool showCrisisBanner;

  const ChatUiState({
    this.messages = const [],
    this.isTyping = false,
    this.errorMessage,
    this.showCrisisBanner = false,
  });

  ChatUiState copyWith({
    List<ChatMessage>? messages,
    bool? isTyping,
    String? errorMessage,
    bool? showCrisisBanner,
  }) {
    return ChatUiState(
      messages: messages ?? this.messages,
      isTyping: isTyping ?? this.isTyping,
      errorMessage: errorMessage, // null explícito limpia el error anterior
      showCrisisBanner: showCrisisBanner ?? this.showCrisisBanner,
    );
  }
}

@riverpod
class ChatMessages extends _$ChatMessages {
  @override
  ChatUiState build() => ChatUiState(
        messages: [
          ChatMessage(
            id: '1',
            text: '¡Hola! Soy SentIA2, tu acompañante emocional. ¿Cómo te sientes en este momento?',
            role: MessageRole.assistant,
            timestamp: DateTime.now(),
          ),
        ],
      );

  Future<void> sendMessage(String text) async {
    final trimmed = text.trim();
    if (trimmed.isEmpty || state.isTyping) return;

    final isRisky = containsRiskSignal(trimmed);

    final userMessage = ChatMessage(
      id: const Uuid().v4(),
      role: MessageRole.user,
      text: trimmed,
      timestamp: DateTime.now(),
      isRiskFlagged: isRisky,
    );

    state = state.copyWith(
      messages: [...state.messages, userMessage],
      isTyping: true,
      errorMessage: null,
      showCrisisBanner: isRisky ? true : state.showCrisisBanner,
    );

    try {
      final aiService = ref.read(aiServiceProvider);
      final responseText = await aiService.getResponse(trimmed);

      final assistantMessage = ChatMessage(
        id: const Uuid().v4(),
        role: MessageRole.assistant,
        text: responseText,
        timestamp: DateTime.now(),
      );

      state = state.copyWith(
        messages: [...state.messages, assistantMessage],
        isTyping: false,
      );
    } catch (_) {
      state = state.copyWith(
        isTyping: false,
        errorMessage: 'No pude responder en este momento. Intenta de nuevo en unos segundos.',
      );
    }
  }

  void dismissCrisisBanner() => state = state.copyWith(showCrisisBanner: false);

  void dismissError() => state = state.copyWith(errorMessage: null);
}
