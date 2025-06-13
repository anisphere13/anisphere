// Copilot Prompt : OfflineGpsQueue to store GPS tracks when offline, with IA analysis before upload and retry on failure.
library;

import 'package:hive/hive.dart';
import 'package:flutter/foundation.dart';
import '../logic/ia_gps_analyzer.dart';

part 'offline_gps_queue.g.dart';

@HiveType(typeId: 150)
class GpsPoint {
  @HiveField(0)
  final double lat;

  @HiveField(1)
  final double lon;

  @HiveField(2)
  final DateTime timestamp;

  GpsPoint(this.lat, this.lon, {DateTime? timestamp})
      : timestamp = timestamp ?? DateTime.now();
}

@HiveType(typeId: 151)
class GpsBatch {
  @HiveField(0)
  final List<GpsPoint> points;

  @HiveField(1)
  final DateTime createdAt;

  GpsBatch({required this.points, DateTime? createdAt})
      : createdAt = createdAt ?? DateTime.now();
}

class OfflineGpsQueue {
  static const String _boxName = 'offline_gps_queue';

  static Future<void> addBatch(GpsBatch batch) async {
    final box = await Hive.openBox<GpsBatch>(_boxName);
    await box.add(batch);
    debugPrint('📥 Batch GPS ajouté (${batch.points.length} pts).');
  }

  static Future<List<GpsBatch>> getAllBatches() async {
    final box = await Hive.openBox<GpsBatch>(_boxName);
    return box.values.toList();
  }

  static Future<void> clearQueue() async {
    final box = await Hive.openBox<GpsBatch>(_boxName);
    await box.clear();
    debugPrint('🧹 File GPS offline vidée.');
  }

  static Future<void> processQueue(
    Future<void> Function(GpsBatch batch, Map<String, dynamic> analysis) handler,
  ) async {
    final box = await Hive.openBox<GpsBatch>(_boxName);
    int index = 0;
    while (index < box.length) {
      final batch = box.getAt(index);
      if (batch == null) {
        index++;
        continue;
      }
      try {
        final analysis = await IAGpsAnalyzer().analyze(batch);
        await handler(batch, analysis);
        await box.deleteAt(index);
      } catch (e) {
        debugPrint('❌ Erreur traitement batch GPS: $e');
        index++;
      }
    }
  }
}
