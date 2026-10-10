import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sentia2/core/error/result.dart';
import 'package:sentia2/features/status/data/api_status_repository.dart';
import 'package:sentia2/features/status/domain/server_status.dart';

part 'server_status_controller.g.dart';

@riverpod
class ServerStatusController extends _$ServerStatusController {
  @override
  Future<ServerStatus> build() async {
    final result = await ref.watch(statusRepositoryProvider).check();
    return switch (result) {
      Ok(:final value) => value,
      Err(:final failure) => throw failure,
    };
  }

  /// Vuelve a consultar el servidor.
  void retry() => ref.invalidateSelf();
}
