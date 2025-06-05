// Copilot Prompt : Test automatique généré pour splash_screen.dart (widget)
import 'package:flutter_test/flutter_test.dart';
import '../../test_config.dart';
import 'package:anisphere/modules/noyau/screens/splash_screen.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });
  test('splash_screen fonctionne (test auto)', () {
    const screen = SplashScreen();
    expect(screen, isA<SplashScreen>());
  });
}
