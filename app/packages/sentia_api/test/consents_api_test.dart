import 'package:test/test.dart';
import 'package:sentia_api/sentia_api.dart';


/// tests for ConsentsApi
void main() {
  final instance = SentiaApi().getConsentsApi();

  group(ConsentsApi, () {
    //Future<List<ConsentDocumentDto>> consentCurrent() async
    test('test consentCurrent', () async {
      // TODO
    });

    //Future<List<ConsentStatusDto>> consentMine() async
    test('test consentMine', () async {
      // TODO
    });

    //Future consentRecord(RecordConsentDto recordConsentDto) async
    test('test consentRecord', () async {
      // TODO
    });

  });
}
