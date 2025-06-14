import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:anisphere/modules/noyau/models/sync_metrics_model.dart';

import '../../test_config.dart';

void main() {
  late Directory tempDir;

  setUpAll(() async {
    await initTestEnv();
    tempDir = await Directory.systemTemp.createTemp();
    Hive
      ..init(tempDir.path)
      ..registerAdapter(SyncMetricsModelAdapter());
  });

  tearDownAll(() async {
    await Hive.deleteBoxFromDisk('sync_metrics');
    await tempDir.delete(recursive: true);
  });

  test('toJson/fromJson round trip', () {
    final metric = SyncMetricsModel(
      operation: 'upload_animal',
      timestamp: DateTime.parse('2024-01-01T00:00:00Z'),
      success: true,
      details: 'ok',
    );
    final json = metric.toJson();
    final copy = SyncMetricsModel.fromJson(json);
    expect(copy.operation, metric.operation);
    expect(copy.timestamp.toIso8601String(), metric.timestamp.toIso8601String());
    expect(copy.success, metric.success);
    expect(copy.details, metric.details);
  });

  test('Hive adapter saves and retrieves object', () async {
    final box = await Hive.openBox<SyncMetricsModel>('sync_metrics');
    final metric = SyncMetricsModel(
      operation: 'sync_user',
      timestamp: DateTime.now(),
      success: false,
      details: 'network error',
    );
    await box.put('m1', metric);

    final read = box.get('m1');

    expect(read, isNotNull);
    expect(read!.operation, metric.operation);
    expect(read.success, metric.success);
    expect(read.details, metric.details);
    expect(read.timestamp.toIso8601String(), metric.timestamp.toIso8601String());

    await box.close();
  });
}
