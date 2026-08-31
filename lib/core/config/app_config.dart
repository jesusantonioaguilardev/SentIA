import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';

enum AppEnvironment { dev, prod }

class AppConfig {
  static AppEnvironment get environment {
    final value = dotenv.env['APP_ENV'] ?? 'dev';
    return switch (value.toLowerCase()) {
      'prod' || 'production' => AppEnvironment.prod,
      _ => AppEnvironment.dev,
    };
  }

  static String get apiBaseUrl =>
      dotenv.env['API_BASE_URL'] ?? 'http://localhost:3000/api';

  static String get websocketUrl =>
      dotenv.env['WS_BASE_URL'] ?? 'ws://localhost:3000';

  static Future<void> load() async {
    final envFile = File('.env');
    if (await envFile.exists()) {
      await dotenv.load(fileName: '.env');
    } else {
      dotenv.env.clear();
    }
  }
}
