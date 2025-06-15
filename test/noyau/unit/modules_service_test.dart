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

  test('moduleNames matches availableModules', () {
    final names = ModulesService.availableModules.map((m) => m.name).toList();
    expect(ModulesService.moduleNames, names);
  });

  test('categories expose unique categories', () {
    final unique =
        ModulesService.availableModules.map((m) => m.category).toSet();
    expect(ModulesService.categories, unique);
  });

  test('getModulesByCategory filters correctly', () {
    final category = ModulesService.availableModules.first.category;
    final modules = ModulesService.getModulesByCategory(category);
    expect(modules.every((m) => m.category == category), isTrue);
  });
}
