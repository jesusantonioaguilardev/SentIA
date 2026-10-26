import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sentia2/core/error/result.dart';
import 'package:sentia2/features/consent/data/api_consent_repository.dart';
import 'package:sentia2/features/consent/domain/consent.dart';

part 'consent_controller.g.dart';

/// Estado del consentimiento de la persona sobre los documentos vigentes.
@riverpod
class MyConsents extends _$MyConsents {
  @override
  Future<List<ConsentStatus>> build() async {
    final result = await ref.watch(consentRepositoryProvider).myStatus();
    return switch (result) {
      Ok(:final value) => value,
      Err(:final failure) => throw failure,
    };
  }

  /// Registra varias decisiones; se detiene en el primer error.
  Future<Result<void>> recordAll(Map<String, bool> decisions) async {
    final repository = ref.read(consentRepositoryProvider);
    for (final MapEntry(key: documentId, value: granted) in decisions.entries) {
      final result = await repository.record(
        documentId: documentId,
        granted: granted,
      );
      if (result is Err) return result;
    }
    ref.invalidateSelf();
    return const Ok(null);
  }
}
