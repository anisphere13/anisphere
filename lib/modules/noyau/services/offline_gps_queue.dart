library;

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'offline_gps_queue.g.dart';

@HiveType(typeId: 133)
class GpsBatch {
  @HiveField(0)
  final List<Map<String, dynamic>> data;

  @HiveField(1)
  final DateTime timestamp;

  GpsBatch({required this.data, DateTime? timestamp})
      : timestamp = timestamp ?? DateTime.now();
}

class OfflineGpsQueue {
  static const String _boxName = 'offline_gps_batches';

  static Future<void> addBatch(List<Map<String, dynamic>> batch) async {
    final box = await Hive.openBox<GpsBatch>(_boxName);
    await box.add(GpsBatch(data: batch));
    debugPrint('📥 Batch GPS ajouté à la file offline : ${batch.length} entrées');
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
}
