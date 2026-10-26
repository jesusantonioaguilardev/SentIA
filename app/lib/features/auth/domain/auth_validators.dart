/// Reglas de los formularios de cuenta. Dart puro: se reutilizan en la UI y en
/// tests. Deben coincidir con el backend (`backend/src/modules/auth/dto`).
abstract final class AuthValidators {
  static const minPasswordLength = 12;
  static const maxPasswordLength = 128;
  static const minAge = 18;

  static final _email = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]{2,}$');

  static bool isEmail(String value) => _email.hasMatch(value.trim());

  static bool isValidPassword(String value) =>
      value.length >= minPasswordLength && value.length <= maxPasswordLength;

  /// Año plausible y no en el futuro.
  static bool isValidBirthYear(int? year, {DateTime? now}) {
    final current = (now ?? DateTime.now()).year;
    return year != null && year >= 1900 && year <= current;
  }

  /// Con solo el año: quien cumple 18 este año pasa (igual que el backend).
  static bool isAdult(int birthYear, {DateTime? now}) =>
      (now ?? DateTime.now()).year - birthYear >= minAge;
}
