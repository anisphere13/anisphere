import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
@Skip('Temporarily disabled')
import 'package:hive/hive.dart';
import 'package:anisphere/services/ia/ia_metrics_collector.dart';
import '../../test_config.dart';

void main() {
  late Directory tempDir;

  setUp(() async {
    await initTestEnv();
    tempDir = await Directory.systemTemp.createTemp();
    Hive.init(tempDir.path);
    Hive.registerAdapter(IAMetricAdapter());
    await Hive.openBox<IAMetric>('ia_metrics');
  });

  tearDown(() async {
    await Hive.deleteBoxFromDisk('ia_metrics');
    await tempDir.delete(recursive: true);
  });

  test('logEducationEvent stores metric with module context', () async {
    await IAMetricsCollector.logEducationEvent(
      type: 'lesson_completed',
      animalId: 'a1',
      userId: 'u1',
      data: {'score': 5},
    );
    final metrics = await IAMetricsCollector.getAllMetrics();
    expect(metrics.length, 1);
    final metric = metrics.first;
    expect(metric.module, 'education');
    expect(metric.type, 'lesson_completed');
    expect(metric.animalId, 'a1');
    expect(metric.userId, 'u1');
    expect(metric.data?['score'], 5);
  });

  test('clearMetrics removes stored metrics', () async {
    await IAMetricsCollector.logEducationEvent(
      type: 'temp',
      animalId: 'a1',
      userId: 'u1',
    );
    await IAMetricsCollector.clearMetrics();
    final metrics = await IAMetricsCollector.getAllMetrics();
    expect(metrics, isEmpty);
  });
}
