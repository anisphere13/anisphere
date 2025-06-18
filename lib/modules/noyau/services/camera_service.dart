// Copilot Prompt : CameraService pour AniSphère.
// Initialise la caméra, gère les permissions et permet de prendre des photos.
// Utilise image_picker pour simplifier la capture.


import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraService {
  final ImagePicker _picker;

  CameraService({ImagePicker? picker}) : _picker = picker ?? ImagePicker();

  /// Vérifie et demande la permission d'accès à la caméra si nécessaire.
  Future<bool> _ensurePermission() async {
    // image_picker gère automatiquement la permission caméra sur mobile.
    // On tente simplement d'accéder à la caméra pour valider.
    try {
      await _picker.pickImage(source: ImageSource.camera);
      return true;
    } catch (e) {
      debugPrint('❌ [CameraService] Permission refusée ou erreur: $e');
      return false;
    }
  }

  /// Ouvre la caméra et retourne le fichier temporaire sélectionné.
  Future<XFile?> takePicture() async {
    final hasPermission = await _ensurePermission();
    if (!hasPermission) return null;
    try {
      final photo = await _picker.pickImage(source: ImageSource.camera);
      if (photo != null) {
        debugPrint('📷 Photo capturée : ${photo.path}');
      }
      return photo;
    } catch (e) {
      debugPrint('❌ [CameraService] Erreur prise de photo: $e');
      return null;
    }
  }
}
