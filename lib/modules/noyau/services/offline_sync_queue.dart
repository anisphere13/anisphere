// Copilot Prompt : OfflineSyncQueue handles buffered sync for AniSphère when offline. Uses Hive to store temporary data and flushes on reconnect.
library;

import 'package:hive/hive.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

part 'offline_sync_queue.g.dart';

@HiveType(typeId: 100)
class SyncTask {
  @HiveField(0)
  final String type; // "animal", "user", "module", etc.

  @HiveField(1)
  final Map<String, dynamic> data;

  @HiveField(2)
  final DateTime timestamp;

  // Unique id to allow easy deletion and merging with previous implementation
  @HiveField(3)
  final String id;

  SyncTask({
    required this.type,
    required this.data,
    DateTime? timestamp,
    String? id,
  })  : timestamp = timestamp ?? DateTime.now(),
        id = id ?? const Uuid().v4();
}

class OfflineSyncQueue {
  static const String _boxName = "offline_sync_queue";
  static const String taskNotificationFeedback = 'notification_feedback';

  static Future<void> addTask(SyncTask task) async {
    final box = await Hive.openBox<SyncTask>(_boxName);
    await box.put(task.id, task);
    debugPrint("📥 Tâche ajoutée à la file offline : ${task.type}");
  }

  static Future<void> removeTask(String id) async {
    final box = await Hive.openBox<SyncTask>(_boxName);
    await box.delete(id);
    debugPrint('🗑️ Tâche supprimée de la file offline : $id');
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
    final failedTasks = <SyncTask>[];
    for (final task in tasks) {
      try {
        await process(task);
      } catch (e) {
        debugPrint("❌ Erreur lors du traitement de ${task.type} : $e");
        failedTasks.add(task);
      }
    }
    await box.clear();
    for (final task in failedTasks) {
      await box.put(task.id, task);
    }
  }
}
