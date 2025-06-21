import 'package:flutter_test/flutter_test.dart';
import 'package:anisphere/modules/noyau/services/ia_gps_analyzer.dart';
import 'package:anisphere/modules/noyau/models/gps_point.dart';

import '../../test_config.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });

  test('compressPath reduces points', () {
    const analyzer = IAGPSAnalyzer();
    final now = DateTime.now();
    final path = [
      GPSPoint(lat: 0, lon: 0, time: now),
      GPSPoint(lat: 0.1, lon: 0, time: now),
      GPSPoint(lat: 0.2, lon: 0, time: now),
      GPSPoint(lat: 0.3, lon: 0, time: now),
    ];
    final compressed = analyzer.compressPath(path);
    expect(compressed.length, 2);
  });

  test('tagStops detects pause', () {
    const analyzer = IAGPSAnalyzer();
    final now = DateTime.now();
    final path = [
      GPSPoint(lat: 0, lon: 0, time: now),
      GPSPoint(lat: 0, lon: 0, time: now.add(const Duration(seconds: 30))),
      GPSPoint(lat: 0, lon: 0, time: now.add(const Duration(seconds: 90))),
      GPSPoint(lat: 0, lon: 0.001, time: now.add(const Duration(seconds: 91))),
    ];
    final stops = analyzer.tagStops(path,
        speedThreshold: 0.1, minStopDuration: const Duration(seconds: 60));
    expect(stops, contains(0));
  });

  test('tagAnomalies detects big jumps', () {
    const analyzer = IAGPSAnalyzer();
    final now = DateTime.now();
    final path = [
      GPSPoint(lat: 0, lon: 0, time: now),
      GPSPoint(lat: 0, lon: 0.001, time: now.add(const Duration(seconds: 10))),
      GPSPoint(lat: 50, lon: 0, time: now.add(const Duration(seconds: 20))),
    ];
    final anomalies = analyzer.tagAnomalies(path, distanceThreshold: 1000);
    expect(anomalies, contains(2));
  });
}
