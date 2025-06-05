// Copilot Prompt : Module IA pour collecte de métriques et gestion offline-first.
// Contient IAMetricsCollector (score IA) et OfflineSyncQueue (buffer de synchronisation).

library;

import 'package:hive/hive.dart';
import 'package:flutter/foundation.dart';

part 'ia_storage_modules.g.dart';

/// 📊 Collecteur de métriques IA locales (score, feedbacks, anomalies)
@HiveType(typeId: 60)
class IAMetrics {
  @HiveField(0)
  final String key;

  @HiveField(1)
  final Map<String, dynamic> data;

  @HiveField(2)
  final DateTime timestamp;

  IAMetrics({required this.key, required this.data, DateTime? timestamp})
      : timestamp = timestamp ?? DateTime.now();
}

class IAMetricsCollector {
  static const String _boxName = 'ia_metrics_box';

  Future<void> saveMetric(IAMetrics metric) async {
    final box = await Hive.openBox<IAMetrics>(_boxName);
    await box.put(metric.key, metric);
    debugPrint("✅ [IAMetrics] Enregistré : ${metric.key}");
  }

  Future<List<IAMetrics>> getAllMetrics() async {
    final box = await Hive.openBox<IAMetrics>(_boxName);
    return box.values.toList();
  }

  Future<void> clear() async {
    final box = await Hive.openBox<IAMetrics>(_boxName);
    await box.clear();
    debugPrint("🧹 [IAMetrics] Nettoyage effectué");
  }
}

/// 📦 File d’attente de synchronisation offline (buffer IA si offline)
@HiveType(typeId: 61)
class SyncTask {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String module;

  @HiveField(2)
  final Map<String, dynamic> payload;

  @HiveField(3)
  final DateTime createdAt;

  SyncTask({
    required this.id,
    required this.module,
    required this.payload,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();
}

class OfflineSyncQueue {
  static const String _boxName = 'sync_queue_box';

  Future<void> enqueue(SyncTask task) async {
    final box = await Hive.openBox<SyncTask>(_boxName);
    await box.put(task.id, task);
    debugPrint("📥 [SyncQueue] Tâche ajoutée : ${task.id}");
  }

  Future<List<SyncTask>> getAllTasks() async {
    final box = await Hive.openBox<SyncTask>(_boxName);
    return box.values.toList();
  }

  Future<void> clear() async {
    final box = await Hive.openBox<SyncTask>(_boxName);
    await box.clear();
    debugPrint("🧹 [SyncQueue] Buffer vidé");
  }

  Future<void> remove(String id) async {
    final box = await Hive.openBox<SyncTask>(_boxName);
    await box.delete(id);
    debugPrint("🗑️ [SyncQueue] Tâche supprimée : $id");
  }
}
