// Copilot Prompt : Test automatique généré pour app_initializer.dart (unit)
import 'package:flutter_test/flutter_test.dart';
import '../../test_config.dart';
import 'package:anisphere/modules/noyau/services/app_initializer.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });
  test('AppInitializer exposes initialize method', () {
    expect(AppInitializer.initialize, isA<Function>());
  });
}
