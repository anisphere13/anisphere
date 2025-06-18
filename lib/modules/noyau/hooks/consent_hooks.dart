
import 'package:flutter/material.dart';

import '../services/consent_service.dart';
import '../screens/legal_screen.dart';

/// Instance globale modifiable pour les tests.
ConsentService consentService = ConsentService();

/// Vérifie que l'utilisateur a donné son consentement pour [type].
/// Si ce n'est pas le cas, affiche [LegalScreen] et retourne le résultat.
Future<bool> ensureConsent(BuildContext context, String type) async {
  final has = await consentService.hasConsent(type);
  if (!context.mounted) return false;
  if (has) return true;

  final accepted = await Navigator.of(context).push<bool>(
    MaterialPageRoute(builder: (_) => LegalScreen(consentType: type)),
  );
  if (accepted == true) {
    await consentService.saveConsent(type);
    return true;
  }
  return false;
}

