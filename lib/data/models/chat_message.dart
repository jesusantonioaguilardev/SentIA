import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sentia2/domain/entities/chat_message.dart';

part 'chat_message.freezed.dart';
part 'chat_message.g.dart';

@freezed
class ChatMessageModel with _$ChatMessageModel {
  const ChatMessageModel._();
  const factory ChatMessageModel({
    required String id,
    required String text,
    required MessageRole role,
    required DateTime timestamp,
  }) = _ChatMessageModel;

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) => _$ChatMessageModelFromJson(json);

  // Mapeo a Entidad de Dominio
  ChatMessage toEntity() => ChatMessage(
    id: id,
    text: text,
    role: role,
    timestamp: timestamp,
  );
}
