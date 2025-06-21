import 'dart:io';

import 'photo_verification_service.dart';

/// Service selecting the best identity photo using local AI scoring.
class IdentityPhotoSelectionService {
  final PhotoVerificationService verifier;

  IdentityPhotoSelectionService({PhotoVerificationService? verifier})
      : verifier = verifier ?? PhotoVerificationService();

  /// Returns the photo with the highest score. Returns null if list empty.
  Future<File?> selectBest(List<File> photos) async {
    if (photos.isEmpty) return null;
    File? best;
    double bestScore = 0.0;
    for (final file in photos) {
      final score = await verifier.scorePhoto(file);
      if (score > bestScore) {
        bestScore = score;
        best = file;
      }
    }
    return best;
  }
}
