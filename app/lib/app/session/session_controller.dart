import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sentia2/core/error/failure.dart';
import 'package:sentia2/core/error/result.dart';
import 'package:sentia2/core/security/token_storage.dart';
import 'package:sentia2/features/consent/data/api_consent_repository.dart';
import 'package:sentia2/features/consent/domain/consent.dart';

part 'session_controller.g.dart';

/// En qué punto está la persona. El router decide la pantalla a partir de esto.
enum SessionStatus {
  /// Sin tokens: bienvenida, login o registro.
  signedOut,

  /// Con sesión, pero sin el consentimiento vigente obligatorio.
  needsConsent,

  /// Con sesión y consentimiento: puede usar la app.
  ready,
}

/// Orquesta sesión y consentimiento. Vive en `app/` porque combina dos
/// features (auth y consent) sin que una importe a la otra (docs/04).
@Riverpod(keepAlive: true)
class Session extends _$Session {
  @override
  Future<SessionStatus> build() async {
    final storage = ref.watch(tokenStorageProvider);
    // Login, registro, logout o un refresh fallido cambian los tokens.
    final subscription = storage.changes.listen((_) => ref.invalidateSelf());
    ref.onDispose(subscription.cancel);

    if (await storage.read() == null) return SessionStatus.signedOut;

    final result = await ref.read(consentRepositoryProvider).myStatus();
    return switch (result) {
      Ok(:final value) =>
        value.allRequiredGranted
            ? SessionStatus.ready
            : SessionStatus.needsConsent,
      // Sin red no se bloquea a quien ya tenía sesión: la ayuda de crisis
      // funciona offline y el backend vuelve a exigir consentimiento.
      Err(failure: NetworkFailure()) => SessionStatus.ready,
      Err() => SessionStatus.needsConsent,
    };
  }

  /// El consentimiento cambió (aceptado en onboarding o retirado en ajustes).
  void refreshConsent() => ref.invalidateSelf();
}
