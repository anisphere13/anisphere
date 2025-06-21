import 'package:flutter_test/flutter_test.dart';
import '../../test_config.dart';
import 'package:anisphere/modules/identite/services/identity_signature_service.dart';
import 'dart:typed_data';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });

  test('signPdf appends signature data', () {
    final service = IdentitySignatureService();
    final data = Uint8List.fromList([1, 2, 3]);
    final signed = service.signPdf(data, 'user');
    expect(signed.length, greaterThan(data.length));
  });
}
