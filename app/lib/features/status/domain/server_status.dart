import 'package:sentia2/core/error/result.dart';

/// Estado del backend según `GET /v1/health`.
class ServerStatus {
  const new({
    required this.databaseUp,
    required this.environment,
    required this.version,
  });

  /// `false` si el servidor responde pero no alcanza la base de datos.
  final bool databaseUp;

  /// Entorno reportado por el servidor (`dev`, `staging`, `prod`).
  final String environment;

  /// Versión del backend.
  final String version;
}

/// Consulta el estado del backend.
abstract interface class StatusRepository {
  /// Devuelve el estado del servidor o un fallo de red/servidor.
  Future<Result<ServerStatus>> check();
}
