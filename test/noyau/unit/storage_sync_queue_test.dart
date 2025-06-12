import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:anisphere/modules/noyau/storage/storage_sync_queue.dart';

void main() {
  late Directory tempDir;

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp();
    Hive.init(tempDir.path);
    Hive.registerAdapter(StorageSyncTaskAdapter());
    await Hive.openBox<StorageSyncTask>('storage_sync_queue');
  });

  tearDown(() async {
    await Hive.deleteBoxFromDisk('storage_sync_queue');
    await tempDir.delete(recursive: true);
  });

  test('enqueue stores task in Hive box', () async {
    final task = StorageSyncTask(
      id: '1',
      targetService: 'firebase',
      filePath: '/tmp/a.txt',
      priority: 5,
    );
    await StorageSyncQueue.enqueue(task);
    final box = await Hive.openBox<StorageSyncTask>('storage_sync_queue');
    expect(box.length, 1);
    expect(box.get('1')?.filePath, '/tmp/a.txt');
  });

  test('dequeue returns highest priority task and removes it', () async {
    await StorageSyncQueue.enqueue(StorageSyncTask(
        id: 'low', targetService: 'fb', filePath: 'a', priority: 1));
    await StorageSyncQueue.enqueue(StorageSyncTask(
        id: 'high', targetService: 'fb', filePath: 'b', priority: 10));
    final task = await StorageSyncQueue.dequeue();
    expect(task?.id, 'high');
    final box = await Hive.openBox<StorageSyncTask>('storage_sync_queue');
    expect(box.length, 1);
  });

  test('processQueue processes tasks and clears box', () async {
    await StorageSyncQueue.enqueue(StorageSyncTask(
        id: '1', targetService: 'fb', filePath: 'a', priority: 0));
    await StorageSyncQueue.enqueue(StorageSyncTask(
        id: '2', targetService: 'fb', filePath: 'b', priority: 0));
    final processed = <String>[];
    await StorageSyncQueue.processQueue((t) async {
      processed.add(t.id);
    });
    expect(processed.length, 2);
    expect(processed, containsAll(['1', '2']));
    final box = await Hive.openBox<StorageSyncTask>('storage_sync_queue');
    expect(box.isEmpty, true);
  });
}
