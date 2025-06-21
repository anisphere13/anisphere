import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
@Skip('Temporarily disabled')
import 'package:hive/hive.dart';
import 'package:anisphere/modules/noyau/services/offline_gps_queue.dart';

void main() {
  late Directory tempDir;

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp();
    Hive.init(tempDir.path);
    Hive.registerAdapter(GpsPointAdapter());
    Hive.registerAdapter(GpsBatchAdapter());
    await Hive.openBox<GpsBatch>('offline_gps_queue');
  });

  tearDown(() async {
    await Hive.deleteBoxFromDisk('offline_gps_queue');
    await tempDir.delete(recursive: true);
  });

  test('addBatch stores batch in Hive box', () async {
    final batch = GpsBatch(points: [GpsPoint(1.0, 2.0)]);
    await OfflineGpsQueue.addBatch(batch);
    final box = await Hive.openBox<GpsBatch>('offline_gps_queue');
    expect(box.length, 1);
    expect(box.getAt(0)?.points.first.lat, 1.0);
  });

  test('processQueue keeps failed batches for retry', () async {
    final batch1 = GpsBatch(points: [GpsPoint(0.0, 0.0)]);
    final batch2 = GpsBatch(points: [GpsPoint(1.0, 1.0)]);
    await OfflineGpsQueue.addBatch(batch1);
    await OfflineGpsQueue.addBatch(batch2);

    var attempts = 0;
    await OfflineGpsQueue.processQueue((b, a) async {
      attempts++;
      if (b == batch1) throw Exception('fail');
    });

    final box = await Hive.openBox<GpsBatch>('offline_gps_queue');
    expect(attempts, 2);
    expect(box.length, 1);
    expect(box.getAt(0)?.points.first.lat, 0.0);

    await OfflineGpsQueue.processQueue((b, a) async {
      attempts++;
    });
    final box2 = await Hive.openBox<GpsBatch>('offline_gps_queue');
    expect(box2.isEmpty, true);
  });

  test('processQueue provides analysis', () async {
    final batch = GpsBatch(points: [GpsPoint(0.0, 0.0), GpsPoint(0.0, 0.1)]);
    await OfflineGpsQueue.addBatch(batch);
    Map<String, dynamic>? info;
    await OfflineGpsQueue.processQueue((b, analysis) async {
      info = analysis;
    });
    expect(info?['points'], 2);
  });
}
