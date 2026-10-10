import 'package:sentia2/domain/entities/user_consent.dart';
import 'package:sentia2/domain/repositories/auth_repository.dart';

class SaveConsentUseCase {
  final AuthRepository repository;

  SaveConsentUseCase(this.repository);

  Future<void> execute(UserConsent consent) async {
    return await repository.saveConsent(consent);
  }
}
