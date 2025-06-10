import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:anisphere/modules/noyau/services/notification_feedback_service.dart';

void main() {
  late Directory tempDir;

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp();
    Hive.init(tempDir.path);
    Hive.registerAdapter(NotificationFeedbackAdapter());
    await Hive.openBox<NotificationFeedback>('notification_feedback');
  });

  tearDown(() async {
    await Hive.deleteBoxFromDisk('notification_feedback');
    await tempDir.delete(recursive: true);
  });

  test('addFeedback stores feedback in Hive box', () async {
    await NotificationFeedbackService.addFeedback('notif1', true);
    final box = await Hive.openBox<NotificationFeedback>('notification_feedback');
    expect(box.length, 1);
    expect(box.getAt(0)?.notificationId, 'notif1');
    expect(box.getAt(0)?.positive, true);
  });

  test('getAllFeedback returns stored entries', () async {
    await NotificationFeedbackService.addFeedback('notif2', false);
    final all = await NotificationFeedbackService.getAllFeedback();
    expect(all.length, 1);
    expect(all.first.notificationId, 'notif2');
    expect(all.first.positive, false);
  });

  test('clear removes all feedback', () async {
    await NotificationFeedbackService.addFeedback('notif3', true);
    await NotificationFeedbackService.clear();
    final all = await NotificationFeedbackService.getAllFeedback();
    expect(all, isEmpty);
  });
}
