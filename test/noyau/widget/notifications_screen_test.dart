import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:anisphere/modules/noyau/screens/notifications_screen.dart';
import '../../test_config.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });

  testWidgets('NotificationsScreen displays sample data', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: NotificationsScreen()));

    expect(find.text('Notifications'), findsOneWidget);
    // One sample module title should appear
    expect(find.text('Santé'), findsOneWidget);
    // One of the sample notification titles
    expect(find.text('Vaccin à jour'), findsOneWidget);
  });
}
