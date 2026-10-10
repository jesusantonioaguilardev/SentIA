import 'package:sentia2/core/error/failure.dart';
import 'package:sentia2/l10n/app_localizations.dart';

/// Mensaje amable y localizado para mostrar un [Failure] al usuario.
extension FailureMessage on Failure {
  String message(AppLocalizations l10n) => switch (this) {
    NetworkFailure() => l10n.errorNetwork,
    ServerFailure() => l10n.errorServer,
    UnexpectedFailure() => l10n.errorUnexpected,
  };
}
