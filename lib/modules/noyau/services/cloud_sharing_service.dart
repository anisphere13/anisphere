// Copilot Prompt : Service de partage cloud pour AniSphère.
// Gère l'upload de fichiers vers Firebase Storage ou un WebDAV/Drive externe.
// Génère des liens de partage à distance et utilise le StorageOptimizer pour la compression.
library;

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'storage_optimizer.dart';
import 'cloud_drive_service.dart';
import 'premium_sharing_checker.dart';

class CloudSharingService {
  final FirebaseStorage _storage;
  final FirebaseFirestore _firestore;
  final CloudDriveService _driveService;
  final PremiumSharingChecker _checker;

  CloudSharingService({
    FirebaseStorage? storage,
    FirebaseFirestore? firestore,
    CloudDriveService? driveService,
    PremiumSharingChecker? checker,
  })  : _storage = storage ?? FirebaseStorage.instance,
        _firestore = firestore ?? FirebaseFirestore.instance,
        _driveService = driveService ?? CloudDriveService(),
        _checker = checker ?? PremiumSharingChecker();

  /// ☁️ Upload un fichier et retourne l'URL de partage.
  /// Si l'utilisateur n'a pas accès au partage cloud, `null` est renvoyé.
  Future<String?> uploadFile(File file, {bool useWebDav = false}) async {
    if (!_checker.canUseCloudSharing()) {
      debugPrint('⛔ [CloudShare] Fonction réservée aux comptes premium');
      return null;
    }

    final optimized = await StorageOptimizer.compressImage(file) ?? file;

    try {
      if (useWebDav) {
        final ok = await _driveService.uploadFile(optimized);
        return ok ? 'drive://${optimized.path}' : null;
      }

      final ref = _storage.ref().child('shares/${optimized.uri.pathSegments.last}');
      await ref.putFile(optimized);
      final url = await ref.getDownloadURL();
      await _firestore.collection('shared_files').add({
        'url': url,
        'createdAt': FieldValue.serverTimestamp(),
      });
      debugPrint('☁️ [CloudShare] Fichier uploadé $url');
      return url;
    } catch (e) {
      debugPrint('❌ [CloudShare] Échec upload : $e');
      return null;
    }
  }
}
