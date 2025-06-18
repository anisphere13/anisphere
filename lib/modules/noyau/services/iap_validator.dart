// Copilot Prompt : Service de validation d'achats in-app pour AniSphère.
// Vérifie les jetons localement et marque les déblocages suspects.
// Utilise LocalStorageService pour verrouiller si la validation échoue.

import 'package:flutter/foundation.dart';

import 'local_storage_service.dart';

class IapValidator {
  static const _validKey = 'iap_valid_tokens';
  static const _suspiciousKey = 'iap_suspicious_tokens';
  static const _lockKey = 'iap_locked';

  /// Vérifie un reçu d'achat localement.
  /// Retourne `true` si le reçu est reconnu comme valide.
  Future<bool> validate(String receipt) async {
    final stored = LocalStorageService.get(_validKey, defaultValue: <String>[]);
    final tokens = stored is List ? stored.cast<String>() : <String>[];
    final isValid = tokens.contains(receipt);
    if (!isValid) {
      await _markSuspicious(receipt);
      await LocalStorageService.set(_lockKey, true);
      debugPrint('❌ Reçu invalide : $receipt');
    } else {
      await LocalStorageService.set(_lockKey, false);
      debugPrint('✅ Reçu valide : $receipt');
    }
    return isValid;
  }

  Future<void> _markSuspicious(String receipt) async {
    final stored = LocalStorageService.get(_suspiciousKey, defaultValue: <String>[]);
    final list = stored is List ? List<String>.from(stored) : <String>[];
    if (!list.contains(receipt)) {
      list.add(receipt);
      await LocalStorageService.set(_suspiciousKey, list);
    }
  }
}
