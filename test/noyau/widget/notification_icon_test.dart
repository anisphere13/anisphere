// Copilot Prompt : Test automatique généré pour notification_icon.dart (widget)
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:anisphere/modules/noyau/widgets/notification_icon.dart';
import '../../test_config.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });
  testWidgets('shows badge when unread notifications exist', (tester) async {
    int taps = 0;
    await tester.pumpWidget(MaterialApp(
      home: NotificationIcon(
        unreadCount: 3,
        onTap: () => taps++,
      ),
    ));

    expect(find.text('3'), findsOneWidget);
    expect(taps, 0);
    await tester.tap(find.byType(IconButton));
    expect(taps, 1);
  });

  testWidgets('hides badge when there are no notifications', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: NotificationIcon(
        unreadCount: 0,
        onTap: () {},
      ),
    ));

    expect(find.text('0'), findsNothing);
    expect(find.byType(Container), findsNothing);
  });
}
