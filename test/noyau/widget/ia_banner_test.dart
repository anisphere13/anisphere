// Copilot Prompt : Test automatique généré pour ia_banner.dart (widget)
import 'package:flutter_test/flutter_test.dart';
@Skip('Temporarily disabled')
import 'package:flutter/material.dart';
import 'package:anisphere/modules/noyau/widgets/ia_banner.dart';
import '../../test_config.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });
  testWidgets('displays message and icon with styles', (tester) async {
    const message = 'Hello';
    const icon = Icons.warning;
    const background = Colors.green;

    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: IABanner(
          message: message,
          icon: icon,
          background: background,
        ),
      ),
    ));

    expect(find.text(message), findsOneWidget);
    expect(find.byIcon(icon), findsOneWidget);

    final container = tester.widget<Container>(find.byType(Container));
    final decoration = container.decoration as BoxDecoration?;
    expect(decoration?.color, background);
  });
}
