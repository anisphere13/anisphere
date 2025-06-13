import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:anisphere/modules/noyau/services/cloud_sync_service.dart';
import 'package:anisphere/modules/noyau/services/offline_photo_queue.dart'
    show PhotoTask, OfflinePhotoQueue, PhotoTaskAdapter;
import 'package:anisphere/modules/noyau/services/offline_sync_queue.dart'
    show SyncTask, OfflineSyncQueue, SyncTaskAdapter;
import 'package:anisphere/modules/noyau/models/photo_model.dart';
import 'package:anisphere/modules/noyau/models/animal_model.dart';
import 'package:anisphere/modules/noyau/models/user_model.dart';
import 'package:anisphere/modules/noyau/services/firebase_service.dart';
import 'package:mockito/mockito.dart';
import '../../test_config.dart';
import '../../helpers/test_fakes.dart';

class FailingFirebaseService extends FirebaseService {
  FailingFirebaseService() : super(firestore: FakeFirestore(), firebaseAuth: FakeFirebaseAuth());

  @override
  Future<bool> savePhoto(PhotoModel photo) async {
    throw Exception('fail');
  }

  @override
  Future<void> sendIALogs(Map<String, dynamic> data) async {
    throw Exception('fail');
  }
}

class MockFirebaseService extends Mock implements FirebaseService {}

void main() {
  late Directory tempDir;

  setUp(() async {
    await initTestEnv();
    tempDir = await Directory.systemTemp.createTemp();
    Hive.init(tempDir.path);
    Hive.registerAdapter(PhotoModelAdapter());
    Hive.registerAdapter(PhotoTaskAdapter());
    Hive.registerAdapter(SyncTaskAdapter());
    await Hive.openBox<PhotoTask>('offline_photo_queue');
    await Hive.openBox<SyncTask>('offline_sync_queue');
  });

  tearDown(() async {
    await Hive.deleteBoxFromDisk('offline_photo_queue');
    await Hive.deleteBoxFromDisk('offline_sync_queue');
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
      uploaded: false,
      remoteUrl: '',
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
      uploaded: false,
      remoteUrl: '',
    );

    await service.pushPhotoData(photo);

    final processed = <PhotoTask>[];
    await OfflinePhotoQueue.processQueue((pt) async {
      processed.add(pt);
    });
    expect(processed.length, 1);
    expect(processed.first.photo.id, 'p2');
  });

  test('pushAnimalData queues task on failure', () async {
    final mock = MockFirebaseService();
    when(mock.saveAnimal(any<AnimalModel>(), forTraining: anyNamed('forTraining')))
        .thenThrow(Exception('fail'));
    final service = CloudSyncService(firebaseService: mock);
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

    await service.pushAnimalData(animal);

    final tasks = await OfflineSyncQueue.getAllTasks();
    expect(tasks.length, 1);
    expect(tasks.first.type, 'animal');
    expect(tasks.first.data['id'], 'a1');
  });

  test('replayOfflineTasks flushes queued tasks', () async {
    final failing = MockFirebaseService();
    when(failing.saveAnimal(any<AnimalModel>(), forTraining: anyNamed('forTraining')))
        .thenThrow(Exception('fail'));
    when(failing.saveUser(any<UserModel>(), forTraining: anyNamed('forTraining')))
        .thenThrow(Exception('fail'));
    when(failing.sendModuleData(any, any)).thenThrow(Exception('fail'));

    final service = CloudSyncService(firebaseService: failing);

    final animal = AnimalModel(
      id: 'a2',
      name: 'bob',
      species: 'cat',
      breed: '',
      imageUrl: '',
      ownerId: 'u1',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    final user = UserModel(
      id: 'u2',
      name: 'Alice',
      email: 'a@b.com',
      phone: '',
      profilePicture: '',
      profession: '',
      ownedSpecies: const {},
      ownedAnimals: const [],
      preferences: const {},
      moduleRoles: const {},
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      activeModules: const [],
      role: 'user',
      iaPremium: false,
    );

    await service.pushAnimalData(animal);
    await service.pushUserData(user);
    await service.pushModuleData('demo', {'v': 1});

    final success = MockFirebaseService();
    when(success.saveAnimal(any<AnimalModel>(), forTraining: anyNamed('forTraining')))
        .thenAnswer((_) async => true);
    when(success.saveUser(any<UserModel>(), forTraining: anyNamed('forTraining')))
        .thenAnswer((_) async => true);
    when(success.sendModuleData(any, any)).thenAnswer((_) async {});

    final replay = CloudSyncService(firebaseService: success);
    await replay.replayOfflineTasks();

    verify(success.saveAnimal(any<AnimalModel>(), forTraining: anyNamed('forTraining')))
        .called(1);
    verify(success.saveUser(any<UserModel>(), forTraining: anyNamed('forTraining'))).called(1);
    verify(success.sendModuleData('demo', any)).called(1);

    final remaining = await OfflineSyncQueue.getAllTasks();
    expect(remaining.isEmpty, isTrue);
  });

  test('syncFullIA uploads logs to Firestore', () async {
    final firestore = FakeFirestore();
    final service = CloudSyncService(firebaseService: FakeFirebaseService(firestore));

    await service.syncFullIA('user123', ['log1', 'log2']);

    final logs = await firestore.collection('ia_logs').get();
    expect(logs.docs.length, greaterThan(0));
    expect(logs.docs.first.data()['userId'], 'user123');
  });

  test('syncFullIA queues logs on failure', () async {
    final service = CloudSyncService(firebaseService: FailingFirebaseService());

    await service.syncFullIA('user321', ['a', 'b']);

    final tasks = await OfflineSyncQueue.getAllTasks();
    expect(tasks.length, 1);
    expect(tasks.first.type, 'ia_logs');
    expect(tasks.first.data['userId'], 'user321');
  });
}
