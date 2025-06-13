import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:anisphere/modules/noyau/services/offline_photo_queue.dart'
    show PhotoTask, OfflinePhotoQueue;
import 'package:anisphere/modules/noyau/models/photo_model.dart';

void main() {
  late Directory tempDir;

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp();
    Hive.init(tempDir.path);
    Hive.registerAdapter(PhotoModelAdapter());
    Hive.registerAdapter(PhotoTaskAdapter());
    await Hive.openBox<PhotoTask>('offline_photo_queue');
  });

  tearDown(() async {
    await Hive.deleteBoxFromDisk('offline_photo_queue');
    await tempDir.delete(recursive: true);
  });

  test('addTask stores photo in Hive box', () async {
    final photo = PhotoModel(
      id: 'p1',
      userId: 'u1',
      animalId: 'a1',
      localPath: '/tmp/1.png',
      createdAt: DateTime.now(),
      uploaded: false,
      remoteUrl: '',
    );
    await OfflinePhotoQueue.addTask(PhotoTask(photo: photo));
    final box = await Hive.openBox<PhotoTask>('offline_photo_queue');
    expect(box.length, 1);
    expect(box.getAt(0)?.photo.id, 'p1');
  });

  test('processQueue processes tasks and clears box', () async {
    final photo = PhotoModel(
      id: 'p2',
      userId: 'u1',
      animalId: 'a1',
      localPath: '/tmp/2.png',
      createdAt: DateTime.now(),
      uploaded: false,
      remoteUrl: '',
    );
    await OfflinePhotoQueue.addTask(PhotoTask(photo: photo));
    final processed = <PhotoTask>[];
    await OfflinePhotoQueue.processQueue((t) async {
      processed.add(t);
    });
    expect(processed.length, 1);
    final box = await Hive.openBox<PhotoTask>('offline_photo_queue');
    expect(box.isEmpty, true);
  });
}
