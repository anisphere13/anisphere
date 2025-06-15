// Copilot Prompt : Test automatique généré pour user_model.g.dart (unit)
import 'package:flutter_test/flutter_test.dart';
import '../../test_config.dart';
import 'package:anisphere/modules/noyau/models/user_model.g.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });
  test('UserModelAdapter typeId is 0', () {
    expect(UserModelAdapter().typeId, 0);
  });
}
