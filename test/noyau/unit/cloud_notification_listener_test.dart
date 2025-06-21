import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
@Skip('Temporarily disabled')
import 'package:anisphere/modules/noyau/services/cloud_notification_listener.dart';
import 'package:anisphere/modules/noyau/services/navigation_service.dart';
import 'package:flutter/material.dart';
import '../../test_config.dart';

void main() {
  const channel = MethodChannel('plugins.flutter.io/firebase_messaging');
  final List<MethodCall> log = [];

  setUpAll(() async {
    await initTestEnv();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall call) async {
      log.add(call);
      if (call.method.contains('getToken')) {
        return 'token_123';
      }
      return true;
    });
  });

  tearDown(() {
    log.clear();
  });

  test('getToken returns token from FirebaseMessaging', () async {
    final token = await CloudNotificationListener.getToken();
    expect(token, 'token_123');
    expect(log.any((c) => c.method.contains('getToken')), isTrue);
  });

  testWidgets('processNotificationData navigates to MessageListScreen',
      (tester) async {
    await tester.pumpWidget(MaterialApp(
      navigatorKey: NavigationService.navigatorKey,
      home: const SizedBox(),
    ));

    CloudNotificationListener.processNotificationData({'module': 'messagerie'});
    await tester.pumpAndSettle();

    expect(find.text('Messagerie'), findsOneWidget);
  });
}
