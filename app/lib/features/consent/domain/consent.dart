import 'package:sentia2/core/error/result.dart';

/// Tipos de documento legal (docs/06 `consent_documents`).
enum ConsentType { privacyNotice, terms, sensitiveData, aiDisclaimer, research }

/// Versión vigente de un documento legal.
class ConsentDocument {
  const new({
    required this.id,
    required this.type,
    required this.version,
    required this.title,
    required this.content,
    required this.required,
    required this.isDraft,
  });

  final String id;
  final ConsentType type;
  final String version;
  final String title;

  /// Markdown sencillo (títulos `#`, `##`, negritas `**`).
  final String content;

  /// Debe aceptarse para usar la app.
  final bool required;

  /// Sin revisión legal: se muestra marcado como borrador [VALIDAR-LEGAL].
  final bool isDraft;
}

/// Decisión vigente de la persona sobre un documento.
class ConsentStatus {
  const new({required this.document, required this.granted});

  final ConsentDocument document;
  final bool granted;
}

extension ConsentStatusList on List<ConsentStatus> {
  /// Aceptó la versión vigente de todos los documentos obligatorios.
  bool get allRequiredGranted =>
      where((s) => s.document.required).every((s) => s.granted);
}

/// Consentimiento versionado contra el backend (docs/09 §1).
abstract interface class ConsentRepository {
  /// Documentos vigentes (públicos).
  Future<Result<List<ConsentDocument>>> currentDocuments();

  /// Estado de la persona autenticada sobre los documentos vigentes.
  Future<Result<List<ConsentStatus>>> myStatus();

  /// Acepta (`granted: true`) o retira una versión concreta.
  Future<Result<void>> record({
    required String documentId,
    required bool granted,
  });
}
