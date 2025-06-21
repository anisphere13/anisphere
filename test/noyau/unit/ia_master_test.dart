// Copilot Prompt : Test automatique généré pour ia_master.dart (unit)
import 'package:flutter_test/flutter_test.dart';
import '../../test_config.dart';
import 'package:anisphere/modules/noyau/logic/ia_master.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });
  test('decideUXMode returns onboarding when first launch', () {
    final master = IAMaster.test();
    final mode = master.decideUXMode(
      isFirstLaunch: true,
      isOffline: false,
      hasAnimals: true,
    );
    expect(mode, 'onboarding_mode');
  });
}
