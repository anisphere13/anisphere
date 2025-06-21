import 'package:flutter_test/flutter_test.dart';
import '../../test_config.dart';
<<<<<<< HEAD
import 'package:anisphere/modules/identite/models/identity_model.dart';
=======
import 'dart:typed_data';
>>>>>>> codex/decider-et-implémenter-l-api-signpdf
import 'package:anisphere/modules/identite/services/identity_signature_service.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });

  test('sign and verify return true for same data', () {
    final service = IdentitySignatureService('secret');
    final data = Uint8List.fromList([1, 2, 3]);
    final sig = service.sign(data);

<<<<<<< HEAD
    expect(service.verify(model, sig), isTrue);
    final other = model.toMap();
    other['status'] = 'changed';
    final changed = IdentityModel.fromMap(other);
    expect(service.verify(changed, sig), isFalse);
=======
    expect(service.verify(data, sig), isTrue);
    expect(service.verify(Uint8List.fromList([3, 2, 1]), sig), isFalse);
>>>>>>> codex/decider-et-implémenter-l-api-signpdf
  });
}
