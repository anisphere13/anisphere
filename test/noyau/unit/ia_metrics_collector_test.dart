import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
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

  test('addMetric stores metric and can be retrieved', () async {
    await IAMetricsCollector.addMetric('score', 5);
    final metrics = await IAMetricsCollector.getAllMetrics();
    expect(metrics.length, 1);
    expect(metrics.first.name, 'score');
    expect(metrics.first.value, 5);
  });

  test('clearMetrics removes stored metrics', () async {
    await IAMetricsCollector.addMetric('temp', 1);
    await IAMetricsCollector.clearMetrics();
    final metrics = await IAMetricsCollector.getAllMetrics();
    expect(metrics, isEmpty);
  });
}
