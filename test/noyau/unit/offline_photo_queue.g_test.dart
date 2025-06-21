// Test pour offline_photo_queue.g.dart
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:anisphere/modules/noyau/services/offline_photo_queue.dart';
import 'package:anisphere/modules/noyau/models/photo_model.dart';
import '../../test_config.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });

  test('adapters write and read tasks', () async {
    final dir = await Directory.systemTemp.createTemp();
    Hive.init(dir.path);
    Hive.registerAdapter(PhotoModelAdapter());
    Hive.registerAdapter(PhotoTaskAdapter());
    final box = await Hive.openBox<PhotoTask>('offline_photo_queue');

    final photo = PhotoModel(
      id: 'p1',
      userId: 'u1',
      animalId: 'a1',
      localPath: 'temp',
      createdAt: DateTime.now(),
      uploaded: false,
      remoteUrl: '',
    );

    await OfflinePhotoQueue.addTask(PhotoTask(
      photo: photo,
      animalId: photo.animalId,
      userId: photo.userId,
    ));

    expect(box.length, 1);
    await box.clear();
    await dir.delete(recursive: true);
  });
}
