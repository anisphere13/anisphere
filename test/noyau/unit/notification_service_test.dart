import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:anisphere/modules/noyau/services/notification_service.dart';
import '../../test_config.dart';

void main() {
  const channel = MethodChannel('dexterous.com/flutter/local_notifications');
  final List<MethodCall> log = [];

  setUpAll(() async {
    await initTestEnv();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall call) async {
      log.add(call);
      return true;
    });
  });

  tearDown(() {
    log.clear();
  });

  test('initialize triggers plugin initialization', () async {
    await NotificationService.initialize();
    expect(log.any((c) => c.method == 'initialize'), isTrue);
  });

  test('showNotification sends show call', () async {
    await NotificationService.showNotification(title: 't', body: 'b', id: 1);
    expect(log.any((c) => c.method == 'show'), isTrue);
  });

  test('cancel cancels specific notification', () async {
    await NotificationService.cancel(1);
    expect(log.any((c) => c.method == 'cancel'), isTrue);
  });

  test('cancelAll cancels all notifications', () async {
    await NotificationService.cancelAll();
    expect(log.any((c) => c.method == 'cancelAll'), isTrue);
  });

  test('fetchPendingNotifications returns list', () async {
    final service = NotificationService();
    final pending = await service.fetchPendingNotifications();
    expect(pending, isNotEmpty);
  });
}
