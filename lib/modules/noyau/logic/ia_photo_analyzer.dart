// Copilot Prompt : IAPhotoAnalyzer pour AniSphère.
// Analyse rapide d'une photo locale (qualité, hash) avant upload.


import 'dart:io';
import 'package:anisphere/modules/identite/services/photo_verification_service.dart';
import 'package:anisphere/modules/noyau/services/storage_optimizer.dart';

class IAPhotoAnalyzer {
  final PhotoVerificationService _verifier = PhotoVerificationService();

  /// Retourne un score de qualité et le hash de l'image optimisée.
  Future<Map<String, dynamic>> analyze(File file) async {
    final score = await _verifier.scorePhoto(file);
    final hash = await StorageOptimizer.computeHash(file);
    return {
      'score': score,
      'hash': hash,
    };
  }
}
