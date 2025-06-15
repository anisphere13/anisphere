import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';

import 'package:anisphere/modules/noyau/logic/ia_master.dart';
import 'package:anisphere/modules/noyau/services/cloud_sync_service.dart';
import 'package:anisphere/modules/noyau/services/offline_sync_queue.dart';
import 'package:anisphere/modules/noyau/services/offline_photo_queue.dart' as offline_queue;
import 'package:anisphere/modules/noyau/models/animal_model.dart';
import 'package:anisphere/modules/noyau/models/photo_model.dart';

import '../../test_config.dart';

class MockCloudSyncService extends Mock implements CloudSyncService {}

void main() {
  late Directory tempDir;
  late MockCloudSyncService mockCloud;

  setUp(() async {
    await initTestEnv();
    tempDir = await Directory.systemTemp.createTemp();
    Hive.init(tempDir.path);
    Hive.registerAdapter(SyncTaskAdapter());
    Hive.registerAdapter(PhotoModelAdapter());
    Hive.registerAdapter(offline_queue.PhotoTaskAdapter());
    Hive.registerAdapter(AnimalModelAdapter());
    await Hive.openBox<SyncTask>('offline_sync_queue');
    await Hive.openBox<offline_queue.PhotoTask>('offline_photo_queue');
    mockCloud = MockCloudSyncService();
    when(mockCloud.pushAnimalData(any<AnimalModel>())).thenAnswer((_) async {});
    when(mockCloud.pushPhotoData(any<PhotoModel>())).thenAnswer((_) async {});
  });

  tearDown(() async {
    await Hive.deleteBoxFromDisk('offline_sync_queue');
    await Hive.deleteBoxFromDisk('offline_photo_queue');
    await tempDir.delete(recursive: true);
  });

  test('processOfflineQueue processes tasks and clears queue', () async {
    final master = IAMaster.test(cloudSyncService: mockCloud);
    final animal = AnimalModel(
      id: 'a1',
      name: 'rex',
      species: 'dog',
      breed: '',
      imageUrl: '',
      ownerId: 'u1',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    final photo = PhotoModel(
      id: 'p1',
      userId: 'u1',
      animalId: 'a1',
      localPath: 'path.jpg',
      createdAt: DateTime.now(),
      uploaded: false,
      remoteUrl: '',
    );

    await OfflineSyncQueue.addTask(
      SyncTask(type: 'animal', data: animal.toJson()),
    );
    await offline_queue.OfflinePhotoQueue.addTask(
      offline_queue.PhotoTask(
        photo: photo,
        animalId: photo.animalId,
        userId: photo.userId,
        uploaded: photo.uploaded,
        remoteUrl: photo.remoteUrl ?? '',
      ),
    );

    await master.processOfflineQueue();

    verify(mockCloud.pushAnimalData(any<AnimalModel>())).called(1);
    verify(mockCloud.pushPhotoData(any<PhotoModel>())).called(1);

    final tasks = await OfflineSyncQueue.getAllTasks();
    final photoBox = await Hive.openBox<offline_queue.PhotoTask>('offline_photo_queue');
    expect(tasks.isEmpty, true);
    expect(photoBox.isEmpty, true);
  });
}
