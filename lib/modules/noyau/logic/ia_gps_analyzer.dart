library;

import 'dart:math';
import '../services/offline_gps_queue.dart';

class IAGpsAnalyzer {
  /// Analyse simple d'un lot de points GPS.
  Future<Map<String, dynamic>> analyze(GpsBatch batch) async {
    double distance = 0;
    for (var i = 1; i < batch.points.length; i++) {
      final p1 = batch.points[i - 1];
      final p2 = batch.points[i];
      distance += _haversine(p1.lat, p1.lon, p2.lat, p2.lon);
    }
    final duration = batch.points.isNotEmpty
        ? batch.points.last.timestamp
            .difference(batch.points.first.timestamp)
            .inSeconds
        : 0;
    return {
      'distance': distance,
      'duration': duration,
      'points': batch.points.length,
    };
  }

  double _haversine(double lat1, double lon1, double lat2, double lon2) {
    const r = 6371000.0;
    final dLat = _deg2rad(lat2 - lat1);
    final dLon = _deg2rad(lon2 - lon1);
    final a =
        sin(dLat / 2) * sin(dLat / 2) +
        cos(_deg2rad(lat1)) * cos(_deg2rad(lat2)) *
            sin(dLon / 2) * sin(dLon / 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return r * c;
  }

  double _deg2rad(double deg) => deg * pi / 180.0;
}
