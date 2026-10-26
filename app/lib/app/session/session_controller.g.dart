// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Orquesta sesión y consentimiento. Vive en `app/` porque combina dos
/// features (auth y consent) sin que una importe a la otra (docs/04).

@ProviderFor(Session)
final sessionProvider = SessionProvider._();

/// Orquesta sesión y consentimiento. Vive en `app/` porque combina dos
/// features (auth y consent) sin que una importe a la otra (docs/04).
final class SessionProvider
    extends $AsyncNotifierProvider<Session, SessionStatus> {
  /// Orquesta sesión y consentimiento. Vive en `app/` porque combina dos
  /// features (auth y consent) sin que una importe a la otra (docs/04).
  SessionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sessionProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sessionHash();

  @$internal
  @override
  Session create() => Session();
}

String _$sessionHash() => r'4992735e6348d8f7d97e6fabd5ad864badcf30e2';

/// Orquesta sesión y consentimiento. Vive en `app/` porque combina dos
/// features (auth y consent) sin que una importe a la otra (docs/04).

abstract class _$Session extends $AsyncNotifier<SessionStatus> {
  FutureOr<SessionStatus> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<SessionStatus>, SessionStatus>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<SessionStatus>, SessionStatus>,
              AsyncValue<SessionStatus>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
