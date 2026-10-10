import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sentia2/core/error/failure.dart';
import 'package:sentia2/core/error/result.dart';

void main() {
  final request = RequestOptions(path: '/v1/health');

  group('Failure.from', () {
    test('timeout y error de conexión → NetworkFailure', () {
      for (final type in [
        DioExceptionType.connectionTimeout,
        DioExceptionType.receiveTimeout,
        DioExceptionType.connectionError,
      ]) {
        expect(
          Failure.from(DioException(requestOptions: request, type: type)),
          isA<NetworkFailure>(),
        );
      }
    });

    test('respuesta de error → ServerFailure con el código de la API', () {
      final failure = Failure.from(
        DioException(
          requestOptions: request,
          type: DioExceptionType.badResponse,
          response: Response(
            requestOptions: request,
            statusCode: 403,
            data: {
              'error': {'code': 'CONSENT_REQUIRED', 'message': '...'},
            },
          ),
        ),
      );
      expect(
        failure,
        isA<ServerFailure>()
            .having((f) => f.statusCode, 'statusCode', 403)
            .having((f) => f.code, 'code', 'CONSENT_REQUIRED'),
      );
    });

    test('cualquier otra cosa → UnexpectedFailure', () {
      expect(Failure.from(StateError('x')), isA<UnexpectedFailure>());
    });

    test('un Failure se conserva', () {
      const failure = NetworkFailure();
      expect(Failure.from(failure), same(failure));
    });
  });

  group('Result.guard', () {
    test('envuelve el valor en Ok', () async {
      final result = await Result.guard(() async => 42);
      expect(result, isA<Ok<int>>().having((r) => r.value, 'value', 42));
    });

    test('convierte excepciones en Err', () async {
      final result = await Result.guard<int>(
        () async => throw DioException(
          requestOptions: request,
          type: DioExceptionType.connectionError,
        ),
      );
      expect(
        result,
        isA<Err<int>>().having(
          (r) => r.failure,
          'failure',
          isA<NetworkFailure>(),
        ),
      );
    });
  });
}
