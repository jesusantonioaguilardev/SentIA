import 'package:flutter_test/flutter_test.dart';
import 'package:sentia2/core/logging/log_redactor.dart';

void main() {
  group('LogRedactor.redact', () {
    test('enmascara correos', () {
      expect(
        LogRedactor.redact('login de ana.perez@correo.mx falló'),
        'login de [REDACTED] falló',
      );
    });

    test('enmascara tokens Bearer y JWT', () {
      const jwt = 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxIn0.c2lnbmF0dXJh';
      expect(LogRedactor.redact('Bearer abc.def-123'), '[REDACTED]');
      expect(LogRedactor.redact('token=$jwt'), 'token=[REDACTED]');
    });

    test('enmascara secuencias largas de dígitos', () {
      expect(LogRedactor.redact('tel 55 1234 5678'), 'tel [REDACTED]');
    });

    test('deja intactos rutas y códigos HTTP', () {
      const message = 'HTTP GET /v1/health → 200';
      expect(LogRedactor.redact(message), message);
    });
  });

  group('LogRedactor.redactContext', () {
    test('oculta claves sensibles sin importar mayúsculas', () {
      final result = LogRedactor.redactContext({
        'Password': 'secreto',
        'note': 'me siento mal',
        'status': 503,
        'missing': null,
      });
      expect(result, {
        'Password': '[REDACTED]',
        'note': '[REDACTED]',
        'status': '503',
        'missing': null,
      });
    });
  });
}
