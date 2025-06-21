import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';

import 'package:anisphere/modules/noyau/models/photo_task.dart';

import '../../test_config.dart';

void main() {
  late Directory tempDir;

  setUpAll(() async {
    await initTestEnv();
    tempDir = await Directory.systemTemp.createTemp();
    Hive
      ..init(tempDir.path)
      ..registerAdapter(PhotoTaskAdapter());
  });

  tearDownAll(() async {
    await Hive.deleteBoxFromDisk('photo_tasks');
    await tempDir.delete(recursive: true);
  });

  test('copyWith updates fields correctly', () {
    const task = PhotoTask(animalId: 'a1', userId: 'u1');
    final updated = task.copyWith(uploaded: true, remoteUrl: 'url');

    expect(updated.animalId, task.animalId);
    expect(updated.userId, task.userId);
    expect(updated.uploaded, isTrue);
    expect(updated.remoteUrl, 'url');
  });

  test('Hive adapter saves and reads object', () async {
    final box = await Hive.openBox<PhotoTask>('photo_tasks');
    const task = PhotoTask(animalId: 'a1', userId: 'u1');
    await box.put('t1', task);

    final read = box.get('t1');

    expect(read, isNotNull);
    expect(read!.animalId, task.animalId);
    expect(read.userId, task.userId);
    expect(read.uploaded, task.uploaded);
    await box.close();
  });
}
