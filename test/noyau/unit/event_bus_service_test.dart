import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
@Skip('Temporarily disabled')
import 'package:hive/hive.dart';
import 'package:anisphere/modules/noyau/services/event_bus_service.dart';
import 'package:anisphere/modules/noyau/models/event_model.dart';
import 'package:anisphere/modules/noyau/event_queue.dart';
import '../../test_config.dart';

void main() {
  late Directory tempDir;
  late EventBusService service;

  setUp(() async {
    await initTestEnv();
    tempDir = await Directory.systemTemp.createTemp();
    Hive.init(tempDir.path);
    Hive.registerAdapter(EventModelAdapter());
    Hive.registerAdapter(QueuedEventAdapter());
    await Hive.openBox<QueuedEvent>('event_queue');
    service = EventBusService();
  });

  tearDown(() async {
    await Hive.deleteBoxFromDisk('event_queue');
    await tempDir.delete(recursive: true);
  });

  test('publish notifies subscribed listeners', () async {
    EventModel? received;
    service.subscribe('test', (e) => received = e);
    await service.publish(EventModel(type: 'test'));
    expect(received?.type, 'test');
  });

  test('replayQueued emits stored events', () async {
    int count = 0;
    service.subscribe('replay', (_) => count++);
    await service.publish(EventModel(type: 'replay'));
    await service.publish(EventModel(type: 'replay'));

    count = 0; // reset before replay
    await service.replayQueued();
    expect(count, 2);
    final box = await Hive.openBox<QueuedEvent>('event_queue');
    expect(box.isEmpty, true);
  });
}
