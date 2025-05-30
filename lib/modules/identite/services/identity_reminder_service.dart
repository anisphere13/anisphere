/// Copilot Prompt : Service de rappel IA pour mise à jour d’identité.
/// Vérifie si la dernière MAJ de l’identité animale dépasse 12 mois.
/// Déclenche une notification IA discrète via IA maîtresse.

library;

import 'package:flutter/foundation.dart';  // Ajout de cet import pour kDebugMode
import 'package:anisphere/modules/identite/models/identity_model.dart';
import 'package:anisphere/modules/noyau/logic/ia_master.dart';

/// Service de rappel IA pour mise à jour d’identité.
/// Vérifie si la dernière MAJ de l’identité animale dépasse 12 mois.
/// Déclenche une notification IA discrète via IA maîtresse.

class IdentityReminderService {
  final IAMaster iaMaster;

  IdentityReminderService({required this.iaMaster});

  void checkIdentityAndNotify(IdentityModel identity) {
    final now = DateTime.now();
    final lastUpdate = identity.lastUpdate;
    final monthsDiff = (now.difference(lastUpdate).inDays / 30).floor();

    if (monthsDiff >= 12) {
      // À remplacer plus tard par : iaMaster.logEvent(...)
      if (kDebugMode) {
        print(
          "🔔 Identité obsolète : ${identity.animalId} non mise à jour depuis $monthsDiff mois.",
        );
      }
    }
  }
}
