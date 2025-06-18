import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pedometer/pedometer.dart';

import '../../test_config.dart';
import 'package:anisphere/modules/noyau/services/behavior_analysis_service.dart';
import 'package:anisphere/modules/noyau/services/device_sensors_service.dart';

class MockDeviceSensorsService extends Mock implements DeviceSensorsService {}

void main() {
  setUpAll(() async {
    await initTestEnv();
  });

  test('analyzeSteps returns pedometer value when no interpreter', () async {
    final sensors = MockDeviceSensorsService();
    when(sensors.pedometerStream)
        .thenAnswer((_) => Stream.value(StepCount(10, DateTime.now())));
    final service = BehaviorAnalysisService(sensors: sensors);

    final result = await service.analyzeSteps();

    expect(result, 10.0);
  });

  test('analyzeSteps returns 0 on sensor error', () async {
    final sensors = MockDeviceSensorsService();
    when(sensors.pedometerStream)
        .thenAnswer((_) => Stream<StepCount>.error(Exception('fail')));
    final service = BehaviorAnalysisService(sensors: sensors);

    final result = await service.analyzeSteps();

    expect(result, 0.0);
  });
}
