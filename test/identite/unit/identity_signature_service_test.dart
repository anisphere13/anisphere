import 'package:flutter_test/flutter_test.dart';
import '../../test_config.dart';
import 'dart:typed_data';
import 'package:anisphere/modules/identite/services/identity_signature_service.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });

  test('sign and verify return true for same data', () {
    final service = IdentitySignatureService('secret');
    final data = Uint8List.fromList([1, 2, 3]);
    final sig = service.sign(data);
    expect(service.verify(data, sig), isTrue);
    expect(service.verify(Uint8List.fromList([3, 2, 1]), sig), isFalse);
  });
}
