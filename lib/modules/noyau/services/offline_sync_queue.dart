/// Copilot Prompt : OfflineSyncQueue handles buffered sync for AniSphère when offline. Uses Hive to store temporary data and flushes on reconnect.
library;

import 'package:hive/hive.dart';
import 'package:flutter/foundation.dart';

part 'offline_sync_queue.g.dart';

@HiveType(typeId: 100)
class SyncTask {
  @HiveField(0)
  final String type; // "animal", "user", "module", etc.

  @HiveField(1)
  final Map<String, dynamic> data;

  @HiveField(2)
  final DateTime timestamp;

  SyncTask({
    required this.type,
    required this.data,
    required this.timestamp,
  });
}

class OfflineSyncQueue {
  static const String _boxName = "offline_sync_queue";

  static Future<void> addTask(SyncTask task) async {
    final box = await Hive.openBox<SyncTask>(_boxName);
    await box.add(task);
    debugPrint("📥 Tâche ajoutée à la file offline : ${task.type}");
  }

  static Future<List<SyncTask>> getAllTasks() async {
    final box = await Hive.openBox<SyncTask>(_boxName);
    return box.values.toList();
  }

  static Future<void> clearQueue() async {
    final box = await Hive.openBox<SyncTask>(_boxName);
    await box.clear();
    debugPrint("🧹 File de synchronisation offline vidée.");
  }

  static Future<void> processQueue(Function(SyncTask) process) async {
    final box = await Hive.openBox<SyncTask>(_boxName);
    final tasks = box.values.toList();
    for (final task in tasks) {
      try {
        await process(task);
      } catch (e) {
        debugPrint("❌ Erreur lors du traitement de ${task.type} : $e");
      }
    }
    await clearQueue();
  }
}
