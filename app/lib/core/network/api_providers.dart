import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sentia2/core/config/app_config.dart';
import 'package:sentia2/core/logging/app_logger.dart';
import 'package:sentia_api/sentia_api.dart';

/// Cliente HTTP único de la app. La app solo habla con el backend de SentIA
/// (docs/03): nunca con proveedores de IA directamente.
final dioProvider = Provider<Dio>((ref) {
  final config = ref.watch(appConfigProvider);
  final dio = Dio(
    BaseOptions(
      baseUrl: config.apiBaseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 30),
    ),
  )..interceptors.add(const _SafeLogInterceptor());
  ref.onDispose(dio.close);
  return dio;
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
