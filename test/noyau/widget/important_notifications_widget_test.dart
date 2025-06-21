import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:anisphere/modules/noyau/widgets/important_notifications_widget.dart';

import '../../test_config.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });

  testWidgets('shows notifications when list is not empty', (tester) async {
    final notifications = ['A', 'B', 'C', 'D'];
    await tester.pumpWidget(
      MaterialApp(
        home: ImportantNotificationsWidget(notifications: notifications),
      ),
    );

    expect(find.text('Notifications importantes'), findsOneWidget);
    // Should only display first three items
    expect(find.textContaining('A'), findsOneWidget);
    expect(find.textContaining('B'), findsOneWidget);
    expect(find.textContaining('C'), findsOneWidget);
    expect(find.textContaining('D'), findsNothing);
  });

  testWidgets('hides widget when list is empty', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: ImportantNotificationsWidget(notifications: []),
    ));

    expect(find.byType(Card), findsNothing);
  });
}
