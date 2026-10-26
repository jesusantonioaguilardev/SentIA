import 'package:sentia2/core/error/failure.dart';
import 'package:sentia2/core/error/failure_message.dart';
import 'package:sentia2/l10n/app_localizations.dart';

/// Mensaje para errores de cuenta: usa el código de la API cuando lo hay.
String authErrorMessage(Object error, AppLocalizations l10n) {
  final failure = Failure.from(error);
  return switch (failure) {
    ServerFailure(code: 'INVALID_CREDENTIALS') =>
      l10n.authErrorInvalidCredentials,
    ServerFailure(code: 'EMAIL_TAKEN') => l10n.authErrorEmailTaken,
    ServerFailure(code: 'UNDERAGE') => l10n.authErrorUnderage,
    ServerFailure(code: 'ACCOUNT_LOCKED') => l10n.authErrorLocked,
    ServerFailure(code: 'VALIDATION_ERROR') => l10n.authErrorValidation,
    _ => failure.message(l10n),
  };
}
