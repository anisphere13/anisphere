import 'package:flutter_test/flutter_test.dart';
import '../../test_config.dart';
<<<<<<< HEAD
import 'package:anisphere/modules/identite/services/identity_signature_service.dart';
import 'dart:typed_data';
=======
import 'package:anisphere/modules/identite/models/identity_model.dart';
import 'package:anisphere/modules/identite/services/identity_signature_service.dart';
>>>>>>> codex/créer-services-et-widgets-sous-lib/modules/identite

void main() {
  setUpAll(() async {
    await initTestEnv();
  });

<<<<<<< HEAD
  test('signPdf appends signature data', () {
    final service = IdentitySignatureService();
    final data = Uint8List.fromList([1, 2, 3]);
    final signed = service.signPdf(data, 'user');
    expect(signed.length, greaterThan(data.length));
=======
  test('sign and verify return true for same data', () {
    final service = IdentitySignatureService('secret');
    final model = IdentityModel(animalId: 'a');
    final sig = service.sign(model);

    expect(service.verify(model, sig), isTrue);
    final other = model.toMap();
    other['status'] = 'changed';
    final changed = IdentityModel.fromMap(other);
    expect(service.verify(changed, sig), isFalse);
>>>>>>> codex/créer-services-et-widgets-sous-lib/modules/identite
  });
}
