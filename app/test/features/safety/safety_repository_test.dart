import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sentia2/features/safety/data/safety_repository_impl.dart';
import 'package:sentia_api/sentia_api.dart';

class _Offline implements HttpClientAdapter {
  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) => throw DioException.connectionError(
    requestOptions: options,
    reason: 'sin red',
  );

  @override
  void close({bool force = false}) {}
}

void main() {
  // La copia empaquetada debe ser idéntica a la del backend (docs/08).
  final bundled = File('assets/safety/resources_mx.json').readAsStringSync();

  test('la copia de la app coincide con el seed del backend', () {
    final backend = File(
      '../backend/src/database/seed-data/safety-resources.mx.json',
    ).readAsStringSync();
    expect(bundled.replaceAll('\r\n', '\n'), backend.replaceAll('\r\n', '\n'));
  });

  test('sin conexión usa la copia empaquetada y lo indica', () async {
    final dio = Dio()..httpClientAdapter = _Offline();
    final repository = SafetyRepositoryImpl(
      SafetyApi(dio),
      () async => bundled,
    );

    final result = await repository.resources();

    expect(result.fromCache, isTrue);
    expect(result.items, isNotEmpty);
    for (final r in result.items) {
      expect(r.verifiedSourceUrl, startsWith('https://www.gob.mx/'));
      expect(r.phone, isNotNull);
    }
  });
}
