// Copilot Prompt : Service d'analyse GPS avec compression et détection d'anomalies.

import 'dart:math';

import '../models/gps_point.dart';

class IAGPSAnalyzer {
  const IAGPSAnalyzer();

  // Copilot: compresse un trajet avec l'algorithme Douglas-Peucker.
  List<GPSPoint> compressPath(List<GPSPoint> path, {double epsilon = 0.0001}) {
    if (path.length < 3) return path;
    final keep = List<bool>.filled(path.length, false);
    keep[0] = true;
    keep[path.length - 1] = true;
    _douglasPeucker(path, 0, path.length - 1, epsilon, keep);
    final result = <GPSPoint>[];
    for (var i = 0; i < path.length; i++) {
      if (keep[i]) result.add(path[i]);
    }
    return result;
  }

  // Copilot: récursion Douglas-Peucker.
  void _douglasPeucker(
      List<GPSPoint> path, int start, int end, double epsilon, List<bool> keep) {
    double maxDist = 0;
    int index = start;
    for (var i = start + 1; i < end; i++) {
      final d = _perpendicularDistance(path[i], path[start], path[end]);
      if (d > maxDist) {
        maxDist = d;
        index = i;
      }
    }
    if (maxDist > epsilon && index != start) {
      keep[index] = true;
      _douglasPeucker(path, start, index, epsilon, keep);
      _douglasPeucker(path, index, end, epsilon, keep);
    }
  }

  // Copilot: distance perpendiculaire à la ligne.
  double _perpendicularDistance(GPSPoint p, GPSPoint start, GPSPoint end) {
    final dx = end.lon - start.lon;
    final dy = end.lat - start.lat;
    if (dx == 0 && dy == 0) return _distance(p, start);
    final nume = (dy * p.lon) - (dx * p.lat) + (end.lon * start.lat) - (end.lat * start.lon);
    final deno = sqrt(dx * dx + dy * dy);
    return nume.abs() / deno;
  }

  // Copilot: calcule la distance haversine entre deux points.
  double _distance(GPSPoint a, GPSPoint b) {
    const r = 6371000.0;
    final dLat = _deg2rad(b.lat - a.lat);
    final dLon = _deg2rad(b.lon - a.lon);
    final la1 = _deg2rad(a.lat);
    final la2 = _deg2rad(b.lat);
    final h = sin(dLat / 2) * sin(dLat / 2) +
        cos(la1) * cos(la2) * sin(dLon / 2) * sin(dLon / 2);
    return 2 * r * atan2(sqrt(h), sqrt(1 - h));
  }

  double _deg2rad(double d) => d * pi / 180;

  // Copilot: tague les arrêts sur un trajet.
  List<int> tagStops(
    List<GPSPoint> path, {
    double speedThreshold = 0.5,
    Duration minStopDuration = const Duration(minutes: 1),
  }) {
    final stops = <int>[];
    var start = -1;
    for (var i = 1; i < path.length; i++) {
      final dist = _distance(path[i], path[i - 1]);
      final secs = path[i].time.difference(path[i - 1].time).inSeconds;
      final speed = secs > 0 ? dist / secs : 0;
      if (speed <= speedThreshold) {
        start = start == -1 ? i - 1 : start;
      } else {
        if (start != -1) {
          final duration = path[i - 1].time.difference(path[start].time);
          if (duration >= minStopDuration) stops.add(start);
          start = -1;
        }
      }
    }
    if (start != -1) {
      final duration = path.last.time.difference(path[start].time);
      if (duration >= minStopDuration) stops.add(start);
    }
    return stops;
  }

  // Copilot: détecte les anomalies de distance excessive.
  List<int> tagAnomalies(List<GPSPoint> path, {double distanceThreshold = 1000}) {
    final anomalies = <int>[];
    for (var i = 1; i < path.length; i++) {
      final dist = _distance(path[i], path[i - 1]);
      if (dist > distanceThreshold) {
        anomalies.add(i);
      }
    }
    return anomalies;
  }
}
