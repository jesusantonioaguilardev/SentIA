import 'package:test/test.dart';
import 'package:sentia_api/sentia_api.dart';


/// tests for MeApi
void main() {
  final instance = SentiaApi().getMeApi();

  group(MeApi, () {
    //Future<Map<String, Object>> meExport() async
    test('test meExport', () async {
      // TODO
    });

    //Future<ProfileDto> meGet() async
    test('test meGet', () async {
      // TODO
    });

    //Future meRemove(DeleteAccountDto deleteAccountDto) async
    test('test meRemove', () async {
      // TODO
    });

    //Future<ProfileDto> meUpdate(UpdateProfileDto updateProfileDto) async
    test('test meUpdate', () async {
      // TODO
    });

  });
}
