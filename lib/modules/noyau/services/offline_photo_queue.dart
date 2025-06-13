library;

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import '../models/photo_model.dart';

part 'offline_photo_queue.g.dart';

@HiveType(typeId: 131)
class QueuedPhoto {
  @HiveField(0)
  final PhotoModel photo;

  @HiveField(1)
  final DateTime timestamp;

  QueuedPhoto({required this.photo, DateTime? timestamp})
      : timestamp = timestamp ?? DateTime.now();
}

@HiveType(typeId: 132)
class PhotoTask {
  @HiveField(0)
  final PhotoModel photo;

  @HiveField(1)
  final DateTime timestamp;

  @HiveField(2)
  final String animalId;

  @HiveField(3)
  final String userId;

  @HiveField(4)
  final bool uploaded;

  @HiveField(5)
  final String? remoteUrl;

  PhotoTask({
    required this.photo,
    required this.animalId,
    required this.userId,
    this.uploaded = false,
    this.remoteUrl,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();
}

class OfflinePhotoQueue {
  static const String _boxName = 'offline_photos';
  static const String _taskBoxName = 'offline_photo_queue';

  static Future<void> addTask(PhotoTask task) async {
    final box = await Hive.openBox<PhotoTask>(_taskBoxName);
    await box.add(task);
    debugPrint('📥 PhotoTask ajouté à la file offline : ${task.photo.id}');
  }

  static Future<void> processQueue(
      Future<void> Function(PhotoTask) handler) async {
    final box = await Hive.openBox<PhotoTask>(_taskBoxName);
    final tasks = box.values.toList();
    for (final task in tasks) {
      try {
        await handler(task);
      } catch (e) {
        debugPrint('❌ Erreur lors du traitement de ${task.photo.id} : $e');
      }
    }
    await box.clear();
  }

  static Future<void> addPhoto(PhotoModel photo) async {
    final box = await Hive.openBox<QueuedPhoto>(_boxName);
    await box.add(QueuedPhoto(photo: photo));
    debugPrint('📥 Photo ajoutée à la file offline : ${photo.id}');
  }

  static Future<List<QueuedPhoto>> getAllPhotos() async {
    final box = await Hive.openBox<QueuedPhoto>(_boxName);
    return box.values.toList();
  }

  static Future<void> clearQueue() async {
    final box = await Hive.openBox<QueuedPhoto>(_boxName);
    await box.clear();
    debugPrint('🧹 File de photos offline vidée.');
  }
}
