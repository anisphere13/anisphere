// Copilot Prompt : PhotoProvider pour AniSphère.
// Gère les photos locales via Hive et la mise en file d'attente pour l'upload.

library;

import 'package:flutter/material.dart';
import '../models/photo_model.dart';
import '../services/offline_photo_queue.dart';
import 'package:hive/hive.dart';

class PhotoProvider extends ChangeNotifier {
  static const String _boxName = 'photos';
  final Map<String, PhotoModel> _photos = {};

  Future<void> init() async {
    await Hive.openBox<PhotoModel>(_boxName);
    await _loadPhotos();
  }

  Future<void> _loadPhotos() async {
    final box = await Hive.openBox<PhotoModel>(_boxName);
    _photos
      ..clear()
      ..addEntries(box.values.map((p) => MapEntry(p.id, p)));
    notifyListeners();
  }

  List<PhotoModel> get photos => _photos.values.toList();

  Future<void> addPhoto(PhotoModel photo) async {
    final box = await Hive.openBox<PhotoModel>(_boxName);
    await box.put(photo.id, photo);
    _photos[photo.id] = photo;
    notifyListeners();
    await OfflinePhotoQueue.addTask(PhotoTask(photo: photo));
  }

  Future<void> markUploaded(String id, String remoteUrl) async {
    final box = await Hive.openBox<PhotoModel>(_boxName);
    final p = box.get(id);
    if (p != null) {
      final updated = p.copyWith(uploaded: true, remoteUrl: remoteUrl);
      await box.put(id, updated);
      _photos[id] = updated;
      notifyListeners();
    }
  }
}
