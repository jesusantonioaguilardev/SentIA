import 'package:sentia2/core/error/result.dart';

/// Contacto de confianza opcional. La persona registrada debe estar
/// informada (docs/02 Etapa 1). En el servidor se guarda cifrado.
class EmergencyContact {
  const new({required this.name, required this.phone});

  final String name;
  final String phone;
}

class Profile {
  const new({
    required this.email,
    required this.birthYear,
    this.displayName,
    this.emergencyContact,
  });

  final String email;
  final int birthYear;
  final String? displayName;
  final EmergencyContact? emergencyContact;
}

abstract interface class ProfileRepository {
  Future<Result<Profile>> get();

  Future<Result<Profile>> update({
    String? displayName,
    EmergencyContact? emergencyContact,
  });

  Future<Result<void>> clearEmergencyContact();

  /// JSON con todos los datos de la persona (ARCO, docs/09).
  Future<Result<String>> export();

  /// Borra la cuenta de inmediato (ADR-0007) y cierra la sesión local.
  Future<Result<void>> deleteAccount(String password);
}

/// Teléfono con dígitos, espacios, guiones o paréntesis (como el backend).
bool isValidPhone(String value) =>
    RegExp(r'^[+\d][\d\s\-()]{6,24}$').hasMatch(value.trim());
