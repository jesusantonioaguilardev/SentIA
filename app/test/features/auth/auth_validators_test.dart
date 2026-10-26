import 'package:flutter_test/flutter_test.dart';
import 'package:sentia2/features/auth/domain/auth_validators.dart';

void main() {
  final now = DateTime(2026, 10, 25);

  test('valida correos', () {
    expect(AuthValidators.isEmail('ana@correo.mx'), isTrue);
    expect(AuthValidators.isEmail('  ana@correo.mx '), isTrue);
    expect(AuthValidators.isEmail('ana@correo'), isFalse);
    expect(AuthValidators.isEmail('sin arroba'), isFalse);
  });

  test('exige contraseñas de 12 a 128 caracteres', () {
    expect(AuthValidators.isValidPassword('a' * 11), isFalse);
    expect(AuthValidators.isValidPassword('a' * 12), isTrue);
    expect(AuthValidators.isValidPassword('a' * 129), isFalse);
  });

  test('año de nacimiento plausible y no futuro', () {
    expect(AuthValidators.isValidBirthYear(1995, now: now), isTrue);
    expect(AuthValidators.isValidBirthYear(1899, now: now), isFalse);
    expect(AuthValidators.isValidBirthYear(2027, now: now), isFalse);
    expect(AuthValidators.isValidBirthYear(null, now: now), isFalse);
  });

  test('mayoría de edad con solo el año, igual que el backend', () {
    expect(AuthValidators.isAdult(2008, now: now), isTrue);
    expect(AuthValidators.isAdult(2009, now: now), isFalse);
  });
}
