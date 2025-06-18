// Copilot Prompt : Test automatique généré pour splash_screen.dart (widget)
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../test_config.dart';
import 'package:anisphere/modules/noyau/screens/main_screen.dart';
import 'package:anisphere/theme.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });
  testWidgets('buttons use transparent overlay without splash', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: appTheme,
        home: const MainScreen(),
      ),
    );

    final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
    final theme = materialApp.theme!;

    final overlayColor = theme.textButtonTheme.style?.overlayColor?.resolve({});
    expect(overlayColor, Colors.transparent);

    expect(theme.splashColor, isNot(const Color(0xFFFBC02D)));
    expect(theme.highlightColor, isNot(const Color(0xFFFBC02D)));

    final elevatedOverlay =
        theme.elevatedButtonTheme.style?.overlayColor?.resolve({});
    expect(elevatedOverlay, Colors.transparent);

    final outlinedOverlay =
        theme.outlinedButtonTheme.style?.overlayColor?.resolve({});
    expect(outlinedOverlay, Colors.transparent);
  });
}
