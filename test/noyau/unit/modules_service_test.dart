// Copilot Prompt : Test automatique généré pour modules_service.dart (unit)
import 'package:flutter_test/flutter_test.dart';
import '../../test_config.dart';
import 'package:anisphere/modules/noyau/services/modules_service.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });
  test('allModules contains Santé', () {
    expect(ModulesService.allModules, contains('Santé'));
  });
}
