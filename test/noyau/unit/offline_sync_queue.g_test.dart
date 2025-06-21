// Copilot Prompt : Test automatique généré pour offline_sync_queue.g.dart (unit)
import 'package:flutter_test/flutter_test.dart';
@Skip('Temporarily disabled')
import '../../test_config.dart';

import 'dart:io';
import 'package:hive/hive.dart';
import 'package:anisphere/modules/noyau/services/offline_sync_queue.dart';

void main() {
  late Directory tempDir;

  setUpAll(() async {
    await initTestEnv();
    tempDir = await Directory.systemTemp.createTemp();
    Hive.init(tempDir.path);
    Hive.registerAdapter(SyncTaskAdapter());
    await Hive.openBox<SyncTask>('offline_sync_queue');
  });

  tearDownAll(() async {
    await Hive.deleteBoxFromDisk('offline_sync_queue');
    await tempDir.delete(recursive: true);
  });

  test('SyncTaskAdapter encodes and decodes SyncTask', () async {
    final task = SyncTask(
      type: 'demo',
      data: {'foo': 'bar'},
      timestamp: DateTime.now(),
    );

    final box = await Hive.openBox<SyncTask>('offline_sync_queue');
    await box.add(task);

    final stored = box.getAt(0);
    expect(stored?.type, equals('demo'));
    expect(stored?.data, equals({'foo': 'bar'}));
    expect(stored?.timestamp.toIso8601String(), task.timestamp.toIso8601String());
  });
}
