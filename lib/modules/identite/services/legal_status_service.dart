// Copilot Prompt : Service pour la gestion du statut juridique de l’animal.
// Permet de déclarer ou modifier le statut (chien d’assistance, travail, élevage...).
// Gère les validations IA, l’enregistrement local et la traçabilité historique.

library;

import 'package:anisphere/modules/identite/models/identity_model.dart';
import 'identity_service.dart';

/// Service pour la gestion du statut juridique de l’animal.
/// Permet de déclarer ou modifier le statut (chien d’assistance, travail, élevage...).
/// Gère les validations IA, l’enregistrement local et la traçabilité historique.

class LegalStatusService {
  final IdentityService identityService;

  LegalStatusService({required this.identityService});

  Future<void> updateLegalStatus({
    required String animalId,
    required String newStatus,
  }) async {
    final identity = identityService.getIdentityLocally(animalId);
    if (identity == null) return;

    // Si 'legalStatus' est null ou vide, on initialise avec un string vide.
    final oldLegalStatus = identity.legalStatus ?? '';

    final updated = IdentityModel(
      animalId: identity.animalId,
      microchipNumber: identity.microchipNumber,
      photoUrl: identity.photoUrl,
      status: identity.status,
      legalStatus: newStatus,
      verifiedByIA: identity.verifiedByIA,
      hasPublicQR: identity.hasPublicQR,
      history: [
        ...identity.history,
        IdentityChange(
          field: 'legalStatus',
          oldValue: oldLegalStatus,
          newValue: newStatus,
          date: DateTime.now(),
        ),
      ],
    );

    await identityService.saveIdentityLocally(updated);
  }
}


