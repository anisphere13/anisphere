// Tests for VideoLogsCollector
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:anisphere/modules/noyau/services/video_logs_collector.dart';
import 'package:anisphere/modules/noyau/services/offline_sync_queue.dart';
import '../../test_config.dart';

class MockCollection extends Mock implements CollectionReference<Map<String, dynamic>> {}
class MockDocument extends Mock implements DocumentReference<Map<String, dynamic>> {}
class MockFirestore extends Mock implements FirebaseFirestore {}

void main() {
  late Directory tempDir;

  setUp(() async {
    await initTestEnv();
    tempDir = await Directory.systemTemp.createTemp();
    Hive.init(tempDir.path);
    Hive.registerAdapter(SyncTaskAdapter());
    await Hive.openBox<SyncTask>('offline_sync_queue');
  });

  tearDown(() async {
    await Hive.deleteBoxFromDisk('offline_sync_queue');
    await tempDir.delete(recursive: true);
  });

  test('uploadResult stores anonymized log', () async {
    final firestore = FakeFirebaseFirestore();
    final collector = VideoLogsCollector(firestoreInstance: firestore);

    final result = {
      'module': 'training',
      'type': 'jump',
      'userId': 'u1',
      'animalId': 'a1',
      'data': {'score': 0.5},
    };

    await collector.uploadResult(result);

    final snap = await firestore
        .collection('logs_ia')
        .doc('training')
        .collection('entries')
        .get();
    expect(snap.docs.length, 1);
    final stored = snap.docs.first.data();
    expect(stored['type'], 'jump');
    expect(stored['userId'], isNot('u1'));
  });

  test('uploadResult queues task on failure', () async {
    final mockFirestore = MockFirestore();
    final mockLogs = MockCollection();
    final mockDoc = MockDocument();
    final mockEntries = MockCollection();
    when(mockFirestore.collection('logs_ia')).thenReturn(mockLogs);
    when(mockLogs.doc(any)).thenReturn(mockDoc);
    when(mockDoc.collection('entries')).thenReturn(mockEntries);
    when(mockEntries.add(any)).thenThrow(Exception('fail'));

    final collector = VideoLogsCollector(firestoreInstance: mockFirestore);

    await collector.uploadResult({
      'module': 'training',
      'userId': 'u1',
      'animalId': 'a1',
    });

    final tasks = await OfflineSyncQueue.getAllTasks();
    expect(tasks.length, 1);
    expect(tasks.first.type, 'video_log');
  });
}
