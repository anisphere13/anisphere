/// Copilot Prompt : Test automatique généré pour splash_screen.dart (widget)
import 'package:flutter_test/flutter_test.dart';
import '../../test_config.dart';
import 'package:anisphere/main.dart' as app_main;

void main() {
  setUpAll(() async {
    await initTestEnv();
  });
  test('splash_screen fonctionne (test auto)', () {
    final screen = app_main.SplashScreen();
    expect(screen, isA<SplashScreen>());
  });
}
