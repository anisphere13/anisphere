import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:anisphere/modules/noyau/services/cloud_notification_listener.dart';
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
}
