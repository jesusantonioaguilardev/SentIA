import 'package:test/test.dart';
import 'package:sentia_api/sentia_api.dart';


/// tests for HealthApi
void main() {
  final instance = SentiaApi().getHealthApi();

  group(HealthApi, () {
    //Future<HealthDto> healthCheck() async
    test('test healthCheck', () async {
      // TODO
    });

  });
}
