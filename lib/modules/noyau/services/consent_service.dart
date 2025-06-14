// Copilot Prompt : Service de gestion des consentements utilisateur.
// Stocke simplement chaque consentement dans LocalStorageService.
library;

import 'package:flutter/foundation.dart';
import 'local_storage_service.dart';

class ConsentService {
  /// Vérifie si l'utilisateur a déjà donné son consentement pour [type].
  Future<bool> hasConsent(String type) async {
    return LocalStorageService.getBool('consent_'
        '$type', defaultValue: false);
  }

  /// Enregistre le consentement de l'utilisateur pour [type].
  Future<void> saveConsent(String type) async {
    await LocalStorageService.set('consent_'
        '$type', true);
    debugPrint('🔐 Consentement enregistré pour $type');
  }
}
