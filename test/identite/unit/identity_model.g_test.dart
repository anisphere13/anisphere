// Copilot Prompt : Test automatique généré pour identity_model.g.dart (unit)
import 'package:flutter_test/flutter_test.dart';
import '../../test_config.dart';
import 'package:anisphere/modules/identite/models/identity_model.g.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });
  test('IdentityModelAdapter typeId is 40', () {
    expect(IdentityModelAdapter().typeId, 40);
  });
}
