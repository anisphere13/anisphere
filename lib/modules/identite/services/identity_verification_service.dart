/// Copilot Prompt : IdentityVerificationService pour AniSphère.
/// Valide automatiquement une fiche identité si la photo est nette, la puce présente,
/// et les données cohérentes. Active le badge IA “Identité vérifiée”.
import 'dart:io';
import 'package:anisphere/modules/identite/models/identity_model.dart';
import 'package:anisphere/modules/identite/services/identity_service.dart';
import 'package:anisphere/modules/identite/services/photo_verification_service.dart';

class IdentityVerificationService {
  final IdentityService identityService;
  final PhotoVerificationService photoVerificationService;

  IdentityVerificationService({
    required this.identityService,
    required this.photoVerificationService,
  });

  Future<void> verifyIdentityAutomatically({
    required IdentityModel identity,
    required String animalName,
  }) async {
    // Conditions minimales : puce présente + photo nette + statut défini
    if (identity.microchipNumber == null || identity.status == null || identity.photoUrl == null) return;

    final photoFile = File(identity.photoUrl!);
    final score = await photoVerificationService.scorePhoto(photoFile);
    final isPhotoValid = score >= 0.6;

    if (isPhotoValid) {
      final updated = IdentityModel(
        animalId: identity.animalId,
        microchipNumber: identity.microchipNumber,
        photoUrl: identity.photoUrl,
        status: identity.status,
        legalStatus: identity.legalStatus,
        verifiedByIA: true,
        hasPublicQR: identity.hasPublicQR,
        history: identity.history,
      );

      await identityService.saveIdentityLocally(updated);
    }
  }
}
