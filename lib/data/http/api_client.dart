import 'package:dio/dio.dart';

import '../../core/config/app_config.dart';

class ApiClient {
  ApiClient() : _dio = Dio(_buildOptions());

  final Dio _dio;

  Dio get dio => _dio;

  static BaseOptions _buildOptions() {
    return BaseOptions(
      baseUrl: AppConfig.apiBaseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      sendTimeout: const Duration(seconds: 15),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
  }
}
