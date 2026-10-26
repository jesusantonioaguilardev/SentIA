/// Recurso de ayuda en crisis (docs/08). Siempre viene de una fuente oficial
/// verificada; nunca se escribe a mano en el código.
class SafetyResource {
  const new({
    required this.name,
    required this.verifiedSourceUrl,
    required this.verifiedAt,
    required this.clinicallyApproved,
    this.description,
    this.phone,
    this.hours,
  });

  final String name;
  final String? description;

  /// Número marcable, sin espacios.
  final String? phone;
  final String? hours;
  final String verifiedSourceUrl;
  final DateTime verifiedAt;

  /// Aprobado por el responsable clínico [VALIDAR-CLÍNICO].
  final bool clinicallyApproved;
}

/// Lista de recursos y si viene del servidor o de la copia local.
class SafetyResources {
  const new({required this.items, required this.fromCache});

  final List<SafetyResource> items;

  /// true si no hubo conexión y se usó la copia empaquetada en la app.
  final bool fromCache;
}

/// Recursos de ayuda. Nunca falla: si no hay red, usa la copia local.
abstract interface class SafetyRepository {
  Future<SafetyResources> resources();
}
