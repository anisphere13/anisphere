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
    final task = SyncTask(
      id: 't1',
      type: 'test',
      data: {'v': 1},
      filePath: '/tmp/file',
      priority: 2,
    );
    await OfflineSyncQueue.addTask(task);
    final box = await Hive.openBox<SyncTask>('offline_sync_queue');
    expect(box.length, 1);
    final stored = box.get('t1');
    expect(stored?.type, 'test');
    expect(stored?.filePath, '/tmp/file');
    expect(stored?.priority, 2);
  });

  test('processQueue processes tasks and clears box', () async {
    final task = SyncTask(id: 'proc', type: 'proc', data: {});
    await OfflineSyncQueue.addTask(task);
    final processed = <SyncTask>[];
    await OfflineSyncQueue.processQueue((t) async {
      processed.add(t);
    });
    expect(processed.length, 1);
    final box = await Hive.openBox<SyncTask>('offline_sync_queue');
    expect(box.isEmpty, true);
  });

  test('processQueue retains failed tasks', () async {
    final task = SyncTask(id: 'fail', type: 'fail', data: {});
    await OfflineSyncQueue.addTask(task);
    await OfflineSyncQueue.processQueue((t) async {
      throw Exception('boom');
    });
    final box = await Hive.openBox<SyncTask>('offline_sync_queue');
    expect(box.length, 1);
    expect(box.get('fail')?.type, 'fail');
  });

  test('clearQueue removes all tasks', () async {
    final task = SyncTask(id: 'clear', type: 'clear', data: {});
    await OfflineSyncQueue.addTask(task);
    await OfflineSyncQueue.clearQueue();
    final box = await Hive.openBox<SyncTask>('offline_sync_queue');
    expect(box.isEmpty, true);
  });
}
