enum MessageRole { user, assistant, system }

class ChatMessage {
  final String id;
  final String text;
  final MessageRole role;
  final DateTime timestamp;

  /// true si el detector de señales de riesgo (ver risk_signal_detector.dart)
  /// marcó este mensaje del usuario. Solo aplica a role == user.
  final bool isRiskFlagged;

  const ChatMessage({
    required this.id,
    required this.text,
    required this.role,
    required this.timestamp,
    this.isRiskFlagged = false,
  });
}
