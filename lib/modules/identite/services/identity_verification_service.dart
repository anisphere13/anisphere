// Copilot Prompt : IdentityVerificationService pour AniSphère.
// Valide automatiquement une fiche identité si la photo est nette, la puce présente,
// et les données cohérentes. Active le badge IA “Identité vérifiée”.


import 'dart:io';
import 'package:anisphere/modules/identite/models/identity_model.dart';
import 'package:anisphere/modules/identite/services/identity_service.dart';
import '../logic/ia_local_analyzer.dart';

/// IdentityVerificationService pour AniSphère.
/// Valide automatiquement une fiche identité si la photo est nette, la puce présente,
/// et les données cohérentes. Active le badge IA “Identité vérifiée”.

class IdentityVerificationService {
  final IdentityService identityService;
  final IdentityLocalAnalyzer analyzer;

  IdentityVerificationService({
    required this.identityService,
    required this.analyzer,
  });

  Future<void> verifyIdentityAutomatically({
    required IdentityModel identity,
    required String animalName,
  }) async {
    // Conditions minimales : puce présente + photo nette + statut défini
    if (identity.microchipNumber == null || identity.status == null || identity.photoUrl == null) {
      return;
    }

    final photoFile = File(identity.photoUrl!);
    
    // Vérifie si le fichier photo existe et est valide
    if (!await photoFile.exists()) {
      return;
    }

    final analysis = await analyzer
        .analyze(IdentityAnalysisInput(photo: photoFile));
    final score = (analysis['photoScore'] as double?) ?? 0.0;
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
