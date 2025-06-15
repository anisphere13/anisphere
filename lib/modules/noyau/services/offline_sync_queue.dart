// Copilot Prompt : OfflineSyncQueue handles buffered sync for AniSphère when offline. Uses Hive to store temporary data and flushes on reconnect.
library;

import 'package:hive/hive.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

part 'offline_sync_queue.g.dart';

@HiveType(typeId: 100)
class SyncTask {
  @HiveField(0)
  final String type; // module or service identifier

  @HiveField(1)
  final Map<String, dynamic>? data;

  @HiveField(2)
  final DateTime timestamp;

  @HiveField(3)
  final String id;

  @HiveField(4)
  final String? filePath;

  @HiveField(5)
  final int priority;

  SyncTask({
    required this.type,
    this.data,
    DateTime? timestamp,
    String? id,
    this.filePath,
    this.priority = 0,
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

  /// Alias kept for backward compatibility
  static Future<void> enqueue(SyncTask task) => addTask(task);

  static Future<void> removeTask(String id) async {
    final box = await Hive.openBox<SyncTask>(_boxName);
    await box.delete(id);
    debugPrint('🗑️ Tâche supprimée de la file offline : $id');
  }

  static Future<List<SyncTask>> getAllTasks() async {
    final box = await Hive.openBox<SyncTask>(_boxName);
    final tasks = box.values.toList();
    tasks.sort((a, b) => b.priority.compareTo(a.priority));
    return tasks;
  }

  static Future<SyncTask?> dequeue() async {
    final box = await Hive.openBox<SyncTask>(_boxName);
    if (box.isEmpty) return null;
    final tasks = await getAllTasks();
    final task = tasks.first;
    await box.delete(task.id);
    return task;
  }

  static Future<void> clearQueue() async {
    final box = await Hive.openBox<SyncTask>(_boxName);
    await box.clear();
    debugPrint("🧹 File de synchronisation offline vidée.");
  }

  static Future<void> processQueue(Function(SyncTask) process) async {
    final box = await Hive.openBox<SyncTask>(_boxName);
    final tasks = await getAllTasks();
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
