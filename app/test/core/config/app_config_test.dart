import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:sentia2/core/config/app_config.dart';

void main() {
  test('AppConfig.appVersion coincide con pubspec.yaml', () {
    final pubspec = File('pubspec.yaml').readAsStringSync();
    final version = RegExp(
      r'^version:\s*(\S+)',
      multiLine: true,
    ).firstMatch(pubspec)!.group(1);
    expect(AppConfig.appVersion, version);
  });
}
