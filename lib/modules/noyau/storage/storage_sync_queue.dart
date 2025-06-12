library;

import 'package:hive/hive.dart';
import 'package:flutter/foundation.dart';

part 'storage_sync_queue.g.dart';

@HiveType(typeId: 122)
class StorageSyncTask {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String targetService;

  @HiveField(2)
  final String filePath;

  @HiveField(3)
  final int priority;

  @HiveField(4)
  final DateTime createdAt;

  StorageSyncTask({
    required this.id,
    required this.targetService,
    required this.filePath,
    this.priority = 0,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();
}

class StorageSyncQueue {
  static const String _boxName = 'storage_sync_queue';

  static Future<void> enqueue(StorageSyncTask task) async {
    final box = await Hive.openBox<StorageSyncTask>(_boxName);
    await box.put(task.id, task);
    debugPrint('📥 [StorageSync] Task queued: ${task.filePath}');
  }

  static Future<StorageSyncTask?> dequeue() async {
    final box = await Hive.openBox<StorageSyncTask>(_boxName);
    if (box.isEmpty) return null;
    final tasks = box.values.toList()
      ..sort((a, b) => b.priority.compareTo(a.priority));
    final task = tasks.first;
    await box.delete(task.id);
    return task;
  }

  static Future<void> processQueue(
      Future<void> Function(StorageSyncTask) handler) async {
    final box = await Hive.openBox<StorageSyncTask>(_boxName);
    final tasks = box.values.toList()
      ..sort((a, b) => b.priority.compareTo(a.priority));
    for (final task in tasks) {
      try {
        await handler(task);
        await box.delete(task.id);
      } catch (e) {
        debugPrint('❌ [StorageSync] Error processing ${task.id}: $e');
      }
    }
  }

  static Future<List<StorageSyncTask>> getAll() async {
    final box = await Hive.openBox<StorageSyncTask>(_boxName);
    return box.values.toList();
  }

  static Future<void> clear() async {
    final box = await Hive.openBox<StorageSyncTask>(_boxName);
    await box.clear();
  }
}
