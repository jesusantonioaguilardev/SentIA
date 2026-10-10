/// Elimina datos sensibles de los mensajes de log antes de escribirlos.
///
/// Es una red de seguridad: la regla principal es no loguear contenido
/// sensible (docs/04, docs/11). Esto atrapa lo que se cuele por error.
abstract final class LogRedactor {
  static const _mask = '[REDACTED]';

  /// Claves cuyo valor nunca se escribe, sin importar su contenido.
  static const sensitiveKeys = {
    'password',
    'token',
    'accesstoken',
    'refreshtoken',
    'authorization',
    'cookie',
    'email',
    'phone',
    'content',
    'text',
    'message',
    'note',
    'answers',
    'transcript',
  };

  static final _patterns = <RegExp>[
    // Bearer / JWT
    RegExp(r'Bearer\s+[A-Za-z0-9\-_.~+/]+=*', caseSensitive: false),
    RegExp(r'eyJ[A-Za-z0-9\-_]+\.[A-Za-z0-9\-_]+\.[A-Za-z0-9\-_]*'),
    // Correos
    RegExp(r'[A-Za-z0-9._%+\-]+@[A-Za-z0-9.\-]+\.[A-Za-z]{2,}'),
    // Secuencias largas de dígitos (teléfonos, tarjetas, IDs oficiales)
    RegExp(r'\+?\d[\d\s\-]{7,}\d'),
  ];

  /// Devuelve [input] con los patrones sensibles enmascarados.
  static String redact(String input) {
    var output = input;
    for (final pattern in _patterns) {
      output = output.replaceAll(pattern, _mask);
    }
    return output;
  }

  /// Devuelve una copia de [context] con las claves sensibles enmascaradas
  /// y el resto de los valores pasados por [redact].
  static Map<String, Object?> redactContext(Map<String, Object?> context) => {
    for (final MapEntry(:key, :value) in context.entries)
      key: sensitiveKeys.contains(key.toLowerCase())
          ? _mask
          : value == null
          ? null
          : redact(value.toString()),
  };
}
