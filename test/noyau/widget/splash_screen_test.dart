// Copilot Prompt : Test automatique généré pour splash_screen.dart (widget)
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../test_config.dart';
import 'package:anisphere/modules/noyau/screens/splash_screen.dart';
import 'package:anisphere/theme.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });
  testWidgets('splash screen uses yellow ripple', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: appTheme,
        home: const SplashScreen(),
      ),
    );

    final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
    final theme = materialApp.theme!;

    expect(theme.highlightColor, const Color(0xFFFBC02D));
    expect(theme.splashColor, const Color(0xFFFBC02D));
  });
}
