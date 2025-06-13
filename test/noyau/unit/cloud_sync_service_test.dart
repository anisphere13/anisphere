import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:anisphere/modules/noyau/services/cloud_sync_service.dart';
import 'package:anisphere/modules/noyau/services/offline_photo_queue.dart';
import 'package:anisphere/modules/noyau/models/photo_model.dart';
import 'package:anisphere/modules/noyau/services/firebase_service.dart';
import '../../test_config.dart';
import '../../helpers/test_fakes.dart';

class FailingFirebaseService extends FirebaseService {
  FailingFirebaseService() : super(firestore: FakeFirestore(), firebaseAuth: FakeFirebaseAuth());

  @override
  Future<bool> savePhoto(PhotoModel photo) async {
    throw Exception('fail');
  }
}

void main() {
  late Directory tempDir;

  setUp(() async {
    await initTestEnv();
    tempDir = await Directory.systemTemp.createTemp();
    Hive.init(tempDir.path);
    Hive.registerAdapter(PhotoModelAdapter());
    Hive.registerAdapter(QueuedPhotoAdapter());
    await Hive.openBox<QueuedPhoto>('offline_photos');
  });

  tearDown(() async {
    await Hive.deleteBoxFromDisk('offline_photos');
    await tempDir.delete(recursive: true);
  });

  test('pushPhotoData uploads photo via FirebaseService', () async {
    final firestore = FakeFirestore();
    final service = CloudSyncService(firebaseService: FakeFirebaseService(firestore));
    final photo = PhotoModel(
      id: 'p1',
      userId: 'u1',
      animalId: 'a1',
      localPath: 'path.jpg',
      createdAt: DateTime.now(),
    );

    await service.pushPhotoData(photo);

    final doc = await firestore.collection('photos').doc('p1').get();
    expect(doc.data()?['id'], 'p1');
  });

  test('pushPhotoData queues photo on failure', () async {
    final service = CloudSyncService(firebaseService: FailingFirebaseService());
    final photo = PhotoModel(
      id: 'p2',
      userId: 'u1',
      animalId: 'a1',
      localPath: 'path.jpg',
      createdAt: DateTime.now(),
    );

    await service.pushPhotoData(photo);

    final queued = await OfflinePhotoQueue.getAllPhotos();
    expect(queued.length, 1);
    expect(queued.first.photo.id, 'p2');
  });
}
