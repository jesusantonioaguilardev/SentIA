class AuthUser {
  const new({
    required this.id,
    required this.email,
    this.displayName,
    this.hasConsented = false,
  });
  final String id;
  final String email;
  final String? displayName;
  final bool hasConsented;
}
