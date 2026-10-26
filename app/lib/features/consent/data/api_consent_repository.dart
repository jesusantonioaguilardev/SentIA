import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sentia2/core/config/app_config.dart';
import 'package:sentia2/core/error/result.dart';
import 'package:sentia2/core/network/api_providers.dart';
import 'package:sentia2/features/consent/domain/consent.dart';
import 'package:sentia_api/sentia_api.dart';

part 'api_consent_repository.g.dart';

@riverpod
ConsentRepository consentRepository(Ref ref) => ApiConsentRepository(
  ref.watch(sentiaApiProvider).getConsentsApi(),
  appVersion: AppConfig.appVersion,
);

class ApiConsentRepository implements ConsentRepository {
  new(this._api, {required this.appVersion});

  final ConsentsApi _api;

  /// Se registra con cada decisión como parte de la evidencia (docs/09).
  final String appVersion;

  @override
  Future<Result<List<ConsentDocument>>> currentDocuments() =>
      Result.guard(() async {
        final response = await _api.consentCurrent();
        return response.data!.map(_toDocument).toList();
      });

  @override
  Future<Result<List<ConsentStatus>>> myStatus() => Result.guard(() async {
    final response = await _api.consentMine();
    return response.data!
        .map(
          (s) => ConsentStatus(
            document: _toDocument(s.document),
            granted: s.granted,
          ),
        )
        .toList();
  });

  @override
  Future<Result<void>> record({
    required String documentId,
    required bool granted,
  }) => Result.guard(() async {
    await _api.consentRecord(
      recordConsentDto: RecordConsentDto(
        documentId: documentId,
        granted: granted,
        appVersion: appVersion,
      ),
    );
  });

  static ConsentDocument _toDocument(ConsentDocumentDto dto) => ConsentDocument(
    id: dto.id,
    type: switch (dto.type) {
      ConsentDocumentDtoTypeEnum.privacyNotice => ConsentType.privacyNotice,
      ConsentDocumentDtoTypeEnum.terms => ConsentType.terms,
      ConsentDocumentDtoTypeEnum.sensitiveData => ConsentType.sensitiveData,
      ConsentDocumentDtoTypeEnum.aiDisclaimer => ConsentType.aiDisclaimer,
      ConsentDocumentDtoTypeEnum.research => ConsentType.research,
    },
    version: dto.version,
    title: dto.title,
    content: dto.content,
    required: dto.required_,
    isDraft: dto.isDraft,
  );
}
