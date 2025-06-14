library;

import 'package:flutter/foundation.dart';

import '../services/consent_service.dart';

/// Provider de gestion des consentements.
/// Charge les consentements via [ConsentService]
/// et notifie lors d'une acceptation ou révocation.
class ConsentProvider with ChangeNotifier {
  final ConsentService _service;
  final Map<String, bool> _consents = {};

  /// Vue non modifiable des consentements courants.
  Map<String, bool> get consents => Map.unmodifiable(_consents);

  ConsentProvider({ConsentService? service})
      : _service = service ?? ConsentService();

  /// Chargement initial des consentements.
  Future<void> loadConsents() async {
    final loaded = await _service.loadConsents();
    _consents
      ..clear()
      ..addAll(loaded);
    notifyListeners();
  }

  /// Retourne l'état d'un consentement donné.
  bool isAccepted(String key) => _consents[key] ?? false;

  /// Accepte un consentement et notifie les listeners.
  Future<void> accept(String key) async {
    await _service.saveConsent(key, true);
    _consents[key] = true;
    notifyListeners();
  }

  /// Révoque un consentement et notifie les listeners.
  Future<void> revoke(String key) async {
    await _service.saveConsent(key, false);
    _consents[key] = false;
    notifyListeners();
  }
}
