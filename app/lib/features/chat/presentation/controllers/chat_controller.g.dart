// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ChatMessages)
final chatMessagesProvider = ChatMessagesProvider._();

final class ChatMessagesProvider
    extends $NotifierProvider<ChatMessages, ChatUiState> {
  ChatMessagesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'chatMessagesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$chatMessagesHash();

  @$internal
  @override
  ChatMessages create() => ChatMessages();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ChatUiState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ChatUiState>(value),
    );
  }
}

String _$chatMessagesHash() => r'fc0cff9084a21121612dcc45656aa5afd2a23aec';

abstract class _$ChatMessages extends $Notifier<ChatUiState> {
  ChatUiState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<ChatUiState, ChatUiState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ChatUiState, ChatUiState>,
              ChatUiState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
