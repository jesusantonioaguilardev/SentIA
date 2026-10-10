import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sentia2/core/error/failure.dart';
import 'package:sentia2/core/error/result.dart';
import 'package:sentia2/core/network/api_providers.dart';
import 'package:sentia2/features/status/domain/server_status.dart';
import 'package:sentia_api/sentia_api.dart';

part 'api_status_repository.g.dart';

@riverpod
StatusRepository statusRepository(Ref ref) =>
    ApiStatusRepository(ref.watch(sentiaApiProvider));

/// [StatusRepository] sobre el cliente generado de la API.
class ApiStatusRepository implements StatusRepository {
  new(this._api);

  final SentiaApi _api;

  @override
  Future<Result<ServerStatus>> check() => Result.guard(() async {
    final response = await _api.getHealthApi().healthCheck(
      // 503 también trae cuerpo: el servidor responde pero la BD no.
      validateStatus: (status) => status == 200 || status == 503,
    );
    final body = response.data;
    if (body == null) throw const UnexpectedFailure();
    return ServerStatus(
      databaseUp: body.database == HealthDtoDatabaseEnum.up,
      environment: body.environment.value,
      version: body.version,
    );
  });
}
