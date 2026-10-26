import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sentia2/core/security/secure_store.dart';

/// Par de tokens de sesión (docs/05: access 15 min + refresh rotativo).
class SessionTokens {
  const new({required this.accessToken, required this.refreshToken});

  final String accessToken;
  final String refreshToken;
}

/// Guarda los tokens solo en almacenamiento seguro y avisa cuando cambian,
/// para que la sesión reaccione (p. ej. si el refresh falla y se borran).
class TokenStorage {
  new(this._store);

  static const _accessKey = 'session.access_token';
  static const _refreshKey = 'session.refresh_token';

  final SecureStore _store;
  final _changes = StreamController<void>.broadcast();

  /// Emite cada vez que se guardan o borran tokens.
  Stream<void> get changes => _changes.stream;

  Future<SessionTokens?> read() async {
    final access = await _store.read(_accessKey);
    final refresh = await _store.read(_refreshKey);
    if (access == null || refresh == null) return null;
    return SessionTokens(accessToken: access, refreshToken: refresh);
  }

  Future<void> save(SessionTokens tokens) async {
    await _store.write(_accessKey, tokens.accessToken);
    await _store.write(_refreshKey, tokens.refreshToken);
    _changes.add(null);
  }

  Future<void> clear() async {
    await _store.delete(_accessKey);
    await _store.delete(_refreshKey);
    _changes.add(null);
  }

  Future<void> dispose() => _changes.close();
}

final tokenStorageProvider = Provider<TokenStorage>((ref) {
  final storage = TokenStorage(ref.watch(secureStoreProvider));
  ref.onDispose(storage.dispose);
  return storage;
});
