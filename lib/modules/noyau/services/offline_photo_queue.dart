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

class OfflinePhotoQueue {
  static const String _boxName = 'offline_photos';

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
