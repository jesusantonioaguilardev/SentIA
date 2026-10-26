import 'dart:async';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sentia2/core/network/auth_interceptor.dart';
import 'package:sentia2/core/security/secure_store.dart';
import 'package:sentia2/core/security/token_storage.dart';

/// Responde 401 a cualquier token que no sea el vigente.
class _Server implements HttpClientAdapter {
  String validToken = 'access-2';
  final seenAuth = <String?>[];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    final auth = options.headers['Authorization'] as String?;
    seenAuth.add(auth);
    final ok = auth == 'Bearer $validToken';
    return ResponseBody.fromString(
      ok ? '{"ok":true}' : '{"error":{"code":"UNAUTHORIZED"}}',
      ok ? 200 : 401,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

void main() {
  late TokenStorage storage;
  late _Server server;
  late Dio dio;
  late int refreshCalls;

  void build(RefreshTokens refresh) {
    dio = Dio(BaseOptions(baseUrl: 'http://test'))..httpClientAdapter = server;
    dio.interceptors.add(
      AuthInterceptor(storage: storage, dio: dio, refresh: refresh),
    );
  }

  setUp(() async {
    storage = TokenStorage(InMemorySecureStore());
    server = _Server();
    refreshCalls = 0;
    await storage.save(
      const SessionTokens(accessToken: 'access-1', refreshToken: 'refresh-1'),
    );
  });

  test('agrega el access token a cada petición', () async {
    server.validToken = 'access-1';
    build((_) => throw StateError('no debería refrescar'));

    await dio.get<dynamic>('/v1/me');

    expect(server.seenAuth.single, 'Bearer access-1');
  });

  test('ante 401 refresca una vez, guarda los tokens y reintenta', () async {
    build((refresh) async {
      refreshCalls++;
      expect(refresh, 'refresh-1');
      return const SessionTokens(
        accessToken: 'access-2',
        refreshToken: 'refresh-2',
      );
    });

    final response = await dio.get<dynamic>('/v1/me');

    expect(response.statusCode, 200);
    expect(refreshCalls, 1);
    expect((await storage.read())!.refreshToken, 'refresh-2');
  });

  test('peticiones simultáneas comparten un solo refresh', () async {
    final gate = Completer<void>();
    build((_) async {
      refreshCalls++;
      await gate.future;
      return const SessionTokens(
        accessToken: 'access-2',
        refreshToken: 'refresh-2',
      );
    });

    final requests = [for (var i = 0; i < 3; i++) dio.get<dynamic>('/v1/me')];
    await Future<void>.delayed(const Duration(milliseconds: 20));
    gate.complete();
    final responses = await Future.wait(requests);

    expect(responses.every((r) => r.statusCode == 200), isTrue);
    expect(refreshCalls, 1);
  });

  test('si el refresh falla, borra la sesión y propaga el 401', () async {
    var changes = 0;
    storage.changes.listen((_) => changes++);
    build((_) async => throw DioException(requestOptions: RequestOptions()));

    await expectLater(
      dio.get<dynamic>('/v1/me'),
      throwsA(
        isA<DioException>().having(
          (e) => e.response?.statusCode,
          'status',
          401,
        ),
      ),
    );
    expect(await storage.read(), isNull);
    expect(changes, greaterThan(0));
  });
}
