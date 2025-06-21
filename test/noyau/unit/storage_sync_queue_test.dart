import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
@Skip('Temporarily disabled')
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

  test('enqueue stores task in Hive box', () async {
    final task = SyncTask(
      id: '1',
      type: 'firebase',
      filePath: '/tmp/a.txt',
      priority: 5,
    );
    await OfflineSyncQueue.enqueue(task);
    final box = await Hive.openBox<SyncTask>('offline_sync_queue');
    expect(box.length, 1);
    expect(box.get('1')?.filePath, '/tmp/a.txt');
  });

  test('dequeue returns highest priority task and removes it', () async {
    await OfflineSyncQueue.enqueue(
        SyncTask(id: 'low', type: 'fb', filePath: 'a', priority: 1));
    await OfflineSyncQueue.enqueue(
        SyncTask(id: 'high', type: 'fb', filePath: 'b', priority: 10));
    final task = await OfflineSyncQueue.dequeue();
    expect(task?.id, 'high');
    final box = await Hive.openBox<SyncTask>('offline_sync_queue');
    expect(box.length, 1);
  });

  test('processQueue processes tasks and clears box', () async {
    await OfflineSyncQueue.enqueue(
        SyncTask(id: '1', type: 'fb', filePath: 'a', priority: 0));
    await OfflineSyncQueue.enqueue(
        SyncTask(id: '2', type: 'fb', filePath: 'b', priority: 0));
    final processed = <String>[];
    await OfflineSyncQueue.processQueue((t) async {
      processed.add(t.id);
    });
    expect(processed.length, 2);
    expect(processed, containsAll(['1', '2']));
    final box = await Hive.openBox<SyncTask>('offline_sync_queue');
    expect(box.isEmpty, true);
  });
}
