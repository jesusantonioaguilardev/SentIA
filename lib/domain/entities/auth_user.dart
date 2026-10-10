class AuthUser {
  final String id;
  final String email;
  final String? displayName;
  final bool hasConsented;

  const AuthUser({
    required this.id,
    required this.email,
    this.displayName,
    this.hasConsented = false,
  });
}
