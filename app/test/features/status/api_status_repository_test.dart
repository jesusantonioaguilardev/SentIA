import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sentia2/core/error/failure.dart';
import 'package:sentia2/core/error/result.dart';
import 'package:sentia2/features/status/data/api_status_repository.dart';
import 'package:sentia2/features/status/domain/server_status.dart';
import 'package:sentia_api/sentia_api.dart';

/// Responde siempre con [statusCode] y [body], sin red.
class _StubAdapter implements HttpClientAdapter {
  new(this.statusCode, this.body);

  final int statusCode;
  final Map<String, Object?> body;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async => ResponseBody.fromString(
    jsonEncode(body),
    statusCode,
    headers: {
      Headers.contentTypeHeader: [Headers.jsonContentType],
    },
  );

  @override
  void close({bool force = false}) {}
}

ApiStatusRepository _repository(int statusCode, Map<String, Object?> body) {
  final dio = Dio(BaseOptions(baseUrl: 'http://test'))
    ..httpClientAdapter = _StubAdapter(statusCode, body);
  return ApiStatusRepository(SentiaApi(dio: dio, interceptors: const []));
}

void main() {
  const body = {
    'status': 'ok',
    'database': 'up',
    'environment': 'dev',
    'version': '0.0.1',
  };

  test('200 → servidor y base de datos arriba', () async {
    final result = await _repository(200, body).check();

    expect(
      result,
      isA<Ok<ServerStatus>>()
          .having((r) => r.value.databaseUp, 'databaseUp', isTrue)
          .having((r) => r.value.environment, 'environment', 'dev'),
    );
  });

  test('503 con cuerpo → servidor arriba, base de datos abajo', () async {
    final result = await _repository(503, {
      ...body,
      'status': 'degraded',
      'database': 'down',
    }).check();

    expect(
      result,
      isA<Ok<ServerStatus>>().having(
        (r) => r.value.databaseUp,
        'databaseUp',
        isFalse,
      ),
    );
  });

  test('500 → ServerFailure', () async {
    final result = await _repository(500, {
      'error': {'code': 'INTERNAL_SERVER_ERROR', 'message': 'Error interno'},
    }).check();

    expect(
      result,
      isA<Err<ServerStatus>>().having(
        (r) => r.failure,
        'failure',
        isA<ServerFailure>(),
      ),
    );
  });
}
