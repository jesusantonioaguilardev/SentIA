import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sentia2/core/config/app_config.dart';
import 'package:sentia2/core/logging/app_logger.dart';
import 'package:sentia2/core/network/auth_interceptor.dart';
import 'package:sentia2/core/security/token_storage.dart';
import 'package:sentia_api/sentia_api.dart';

BaseOptions _baseOptions(AppConfig config) => BaseOptions(
  baseUrl: config.apiBaseUrl,
  connectTimeout: const Duration(seconds: 10),
  receiveTimeout: const Duration(seconds: 30),
);

/// Cliente HTTP único de la app. La app solo habla con el backend de SentIA
/// (docs/03): nunca con proveedores de IA directamente.
final dioProvider = Provider<Dio>((ref) {
  final config = ref.watch(appConfigProvider);
  final storage = ref.watch(tokenStorageProvider);
  final refreshApi = ref.watch(_refreshApiProvider);
  final dio = Dio(_baseOptions(config));
  dio.interceptors.addAll([
    AuthInterceptor(
      storage: storage,
      dio: dio,
      refresh: (refreshToken) async {
        final response = await refreshApi.authRefresh(
          refreshDto: RefreshDto(refreshToken: refreshToken),
        );
        final pair = response.data!;
        return SessionTokens(
          accessToken: pair.accessToken,
          refreshToken: pair.refreshToken,
        );
      },
    ),
    const _SafeLogInterceptor(),
  ]);
  ref.onDispose(dio.close);
  return dio;
});

/// Cliente sin interceptor de auth, solo para refrescar (evita bucles).
final _refreshApiProvider = Provider<AuthApi>((ref) {
  final dio = Dio(_baseOptions(ref.watch(appConfigProvider)))
    ..interceptors.add(const _SafeLogInterceptor());
  ref.onDispose(dio.close);
  return AuthApi(dio);
});

/// Cliente generado desde `backend/openapi.yaml`.
final sentiaApiProvider = Provider<SentiaApi>(
  (ref) => SentiaApi(dio: ref.watch(dioProvider), interceptors: const []),
);

/// Registra método, ruta y estado. Nunca bodies, query ni headers:
/// pueden contener datos sensibles o credenciales.
class _SafeLogInterceptor extends Interceptor {
  const new();

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    final options = response.requestOptions;
    AppLogger.debug(
      'HTTP ${options.method} ${options.uri.path} → ${response.statusCode}',
    );
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final options = err.requestOptions;
    AppLogger.warning('HTTP ${options.method} ${options.uri.path} falló', {
      'type': err.type.name,
      'status': err.response?.statusCode,
    });
    handler.next(err);
  }
}
