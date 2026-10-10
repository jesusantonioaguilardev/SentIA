import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sentia2/core/routing/routes.dart';
import 'package:sentia2/features/chat/domain/entities/chat_message.dart';
import 'package:sentia2/features/chat/presentation/controllers/chat_controller.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const new({super.key});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final TextEditingController _controller = TextEditingController();

  void _handleSend() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      unawaited(ref.read(chatMessagesProvider.notifier).sendMessage(text));
      _controller.clear();
    }
  }

  void _exitChat() {
    context.go(Routes.home);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final chatState = ref.watch(chatMessagesProvider);
    final messages = chatState.messages;

    ref.listen(chatMessagesProvider.select((s) => s.errorMessage), (
      prev,
      next,
    ) {
      if (next != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next),
            action: SnackBarAction(
              label: 'OK',
              onPressed: () =>
                  ref.read(chatMessagesProvider.notifier).dismissError(),
            ),
          ),
        );
      }
    });

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: _exitChat,
          tooltip: 'Salir del chat',
        ),
        title: Row(
          children: [
            Icon(
              Icons.water_drop,
              color: colorScheme.primaryContainer,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              'SentIA Chat',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
      ),
      body: Column(
        children: [
          if (chatState.showCrisisBanner)
            _CrisisBanner(
              onDismiss: () =>
                  ref.read(chatMessagesProvider.notifier).dismissCrisisBanner(),
            ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: messages.length + (chatState.isTyping ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == messages.length) {
                  return const _TypingIndicator();
                }
                final msg = messages[index];
                final isUser = msg.role == MessageRole.user;

                return Align(
                  alignment: isUser
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.75,
                    ),
                    decoration: BoxDecoration(
                      color: isUser
                          ? (msg.isRiskFlagged
                                ? colorScheme.errorContainer
                                : colorScheme.primary)
                          : colorScheme.surfaceContainerLow,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(20),
                        topRight: const Radius.circular(20),
                        bottomLeft: Radius.circular(isUser ? 20 : 4),
                        bottomRight: Radius.circular(isUser ? 4 : 20),
                      ),
                      boxShadow: [
                        if (!isUser)
                          BoxShadow(
                            color: colorScheme.shadow.withValues(alpha: 0.03),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                      ],
                      border: msg.isRiskFlagged
                          ? Border.all(
                              color: colorScheme.error.withValues(alpha: 0.5),
                            )
                          : null,
                    ),
                    child: Text(
                      msg.text,
                      style: TextStyle(
                        color: isUser
                            ? (msg.isRiskFlagged
                                  ? colorScheme.onErrorContainer
                                  : colorScheme.onPrimary)
                            : colorScheme.onSurface,
                        fontSize: 15,
                        height: 1.4,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          _ChatInputField(
            controller: _controller,
            onSend: _handleSend,
            isTyping: chatState.isTyping,
          ),
        ],
      ),
    );
  }
}

class _CrisisBanner extends StatelessWidget {
  const new({required this.onDismiss});
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colorScheme.error.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Icon(Icons.warning_amber_rounded, color: colorScheme.error),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Parece que estás pasando por un momento difícil. Recuerda que no estás solo/a. Si necesitas ayuda urgente, contacta a una línea de emergencia.',
              style: TextStyle(
                color: colorScheme.onErrorContainer,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.close, color: colorScheme.error, size: 20),
            onPressed: onDismiss,
          ),
        ],
      ),
    );
  }
}

class _TypingIndicator extends StatelessWidget {
  const new();
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          'SentIA está pensando...',
          style: TextStyle(
            fontStyle: FontStyle.italic,
            color: colorScheme.onSurfaceVariant,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}

class _ChatInputField extends StatelessWidget {
  const new({
    required this.controller,
    required this.onSend,
    required this.isTyping,
  });
  final TextEditingController controller;
  final VoidCallback onSend;
  final bool isTyping;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                enabled: !isTyping,
                style: TextStyle(fontSize: 15, color: colorScheme.onSurface),
                decoration: InputDecoration(
                  hintText: 'Cuéntame, te escucho...',
                  hintStyle: TextStyle(color: colorScheme.onSurfaceVariant),
                  filled: true,
                  fillColor: colorScheme.surfaceContainerLow,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                ),
                onSubmitted: (_) => onSend(),
              ),
            ),
            const SizedBox(width: 12),
            IconButton.filled(
              icon: const Icon(Icons.send_rounded, size: 20),
              onPressed: isTyping ? null : onSend,
              style: IconButton.styleFrom(
                backgroundColor: colorScheme.primary,
                foregroundColor: colorScheme.onPrimary,
                padding: const EdgeInsets.all(12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
