import 'package:flutter_test/flutter_test.dart';
import '../../test_config.dart';
import 'package:anisphere/modules/identite/models/identity_model.dart';
import 'package:anisphere/modules/identite/services/identity_signature_service.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });

  test('sign and verify return true for same data', () {
    final service = IdentitySignatureService('secret');
    final model = IdentityModel(animalId: 'a');
    final sig = service.sign(model);

    expect(service.verify(model, sig), isTrue);

    final modified = model.toMap();
    modified['status'] = 'changed';
    final changed = IdentityModel.fromMap(modified);
    expect(service.verify(changed, sig), isFalse);
  });
}
