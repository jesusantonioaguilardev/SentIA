import 'package:test/test.dart';
import 'package:sentia_api/sentia_api.dart';


/// tests for SafetyApi
void main() {
  final instance = SentiaApi().getSafetyApi();

  group(SafetyApi, () {
    //Future<List<SafetyResourceDto>> safetyResources({ String country }) async
    test('test safetyResources', () async {
      // TODO
    });

  });
}
