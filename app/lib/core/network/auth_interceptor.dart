import 'dart:async';

import 'package:dio/dio.dart';
import 'package:sentia2/core/logging/app_logger.dart';
import 'package:sentia2/core/security/token_storage.dart';

/// Obtiene un par nuevo de tokens a partir del refresh; lanza si no se puede.
typedef RefreshTokens = Future<SessionTokens> Function(String refreshToken);

/// Agrega el access token y, ante un 401, intenta un único refresh antes de
/// repetir la petición. Las peticiones que fallan a la vez esperan al mismo
/// refresh (una sola petición en vuelo): con refresh rotativo, dos refresh
/// simultáneos se detectarían como reuso y cerrarían la sesión.
class AuthInterceptor extends QueuedInterceptor {
  new({required this.storage, required this.refresh, required this.dio});

  final TokenStorage storage;
  final RefreshTokens refresh;

  /// Dio con el que se reintenta la petición original.
  final Dio dio;

  Future<SessionTokens?>? _inFlight;

  static const _retriedKey = 'auth.retried';

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final tokens = await storage.read();
    if (tokens != null) {
      options.headers['Authorization'] = 'Bearer ${tokens.accessToken}';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final options = err.requestOptions;
    final unauthorized = err.response?.statusCode == 401;
    if (!unauthorized || options.extra[_retriedKey] == true) {
      return handler.next(err);
    }

    final current = await storage.read();
    if (current == null) return handler.next(err);

    // Si otra petición ya refrescó mientras esta esperaba en la cola, basta
    // con reintentar con el token nuevo: refrescar otra vez usaría un refresh
    // ya rotado y el backend cerraría la sesión por reuso.
    final usedToken = options.headers['Authorization'];
    final renewed = usedToken == 'Bearer ${current.accessToken}'
        ? await _refreshOnce(current)
        : current;
    if (renewed == null) return handler.next(err);

    try {
      options
        ..extra[_retriedKey] = true
        ..headers['Authorization'] = 'Bearer ${renewed.accessToken}';
      handler.resolve(await dio.fetch<dynamic>(options));
    } on DioException catch (retryError) {
      handler.next(retryError);
    }
  }

  Future<SessionTokens?> _refreshOnce(SessionTokens current) {
    return _inFlight ??= () async {
      try {
        final renewed = await refresh(current.refreshToken);
        await storage.save(renewed);
        return renewed;
      } on Object catch (error) {
        // Refresh inválido, revocado o reusado: la sesión terminó.
        AppLogger.warning('Sesión expirada', {'errorType': error.runtimeType});
        await storage.clear();
        return null;
      } finally {
        _inFlight = null;
      }
    }();
  }
}
