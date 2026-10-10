import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class AuthLocalDataSource {
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<void> deleteToken();
  Future<void> saveUserId(String userId);
  Future<String?> getUserId();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final FlutterSecureStorage secureStorage;

  AuthLocalDataSourceImpl({required this.secureStorage});

  static const _tokenKey = 'auth_token';
  static const _userIdKey = 'user_id';

  @override
  Future<void> saveToken(String token) async {
    await secureStorage.write(key: _tokenKey, value: token);
  }

  @override
  Future<String?> getToken() async {
    return await secureStorage.read(key: _tokenKey);
  }

  @override
  Future<void> deleteToken() async {
    await secureStorage.delete(key: _tokenKey);
    await secureStorage.delete(key: _userIdKey);
  }

  @override
  Future<void> saveUserId(String userId) async {
    await secureStorage.write(key: _userIdKey, value: userId);
  }

  @override
  Future<String?> getUserId() async {
    return await secureStorage.read(key: _userIdKey);
  }
}
