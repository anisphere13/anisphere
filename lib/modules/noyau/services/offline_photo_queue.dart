// Copilot Prompt : OfflinePhotoQueue pour AniSphère.
// File d'attente Hive pour les photos à envoyer lorsque l'app est hors ligne.

library;

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import '../models/photo_model.dart';

part 'offline_photo_queue.g.dart';

@HiveType(typeId: 103)
class PhotoTask {
  @HiveField(0)
  final PhotoModel photo;

  PhotoTask({required this.photo});
}

class OfflinePhotoQueue {
  static const String _boxName = 'offline_photo_queue';

  static Future<void> addTask(PhotoTask task) async {
    final box = await Hive.openBox<PhotoTask>(_boxName);
    await box.add(task);
    debugPrint('📥 Photo ajoutée à la file offline');
  }

  static Future<List<PhotoTask>> getAllTasks() async {
    final box = await Hive.openBox<PhotoTask>(_boxName);
    return box.values.toList();
  }

  static Future<void> clearQueue() async {
    final box = await Hive.openBox<PhotoTask>(_boxName);
    await box.clear();
  }

  static Future<void> processQueue(
    Future<void> Function(PhotoTask task) process,
  ) async {
    final box = await Hive.openBox<PhotoTask>(_boxName);
    final tasks = box.values.toList();
    for (final t in tasks) {
      await process(t);
    }
    await clearQueue();
  }
}
