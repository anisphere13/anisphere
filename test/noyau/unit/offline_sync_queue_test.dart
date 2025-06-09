import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:anisphere/modules/noyau/services/offline_sync_queue.dart';

void main() {
  late Directory tempDir;

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp();
    Hive.init(tempDir.path);
    Hive.registerAdapter(SyncTaskAdapter());
    await Hive.openBox<SyncTask>('offline_sync_queue');
  });

  tearDown(() async {
    await Hive.deleteBoxFromDisk('offline_sync_queue');
    await tempDir.delete(recursive: true);
  });

  test('addTask stores task in Hive box', () async {
    final task = SyncTask(type: 'test', data: {'v': 1}, timestamp: DateTime.now());
    await OfflineSyncQueue.addTask(task);
    final box = await Hive.openBox<SyncTask>('offline_sync_queue');
    expect(box.length, 1);
    expect(box.getAt(0)?.type, 'test');
  });

  test('processQueue processes tasks and clears box', () async {
    final task = SyncTask(type: 'proc', data: {}, timestamp: DateTime.now());
    await OfflineSyncQueue.addTask(task);
    final processed = <SyncTask>[];
    await OfflineSyncQueue.processQueue((t) async {
      processed.add(t);
    });
    expect(processed.length, 1);
    final box = await Hive.openBox<SyncTask>('offline_sync_queue');
    expect(box.isEmpty, true);
  });

  test('clearQueue removes all tasks', () async {
    final task = SyncTask(type: 'clear', data: {}, timestamp: DateTime.now());
    await OfflineSyncQueue.addTask(task);
    await OfflineSyncQueue.clearQueue();
    final box = await Hive.openBox<SyncTask>('offline_sync_queue');
    expect(box.isEmpty, true);
  });
}
