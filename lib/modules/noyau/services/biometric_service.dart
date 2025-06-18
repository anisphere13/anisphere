// Copilot Prompt : Service d'authentification biométrique pour AniSphère.
// Utilise le plugin local_auth pour vérifier et lancer l'authentification.

import 'package:flutter/foundation.dart';
import 'package:local_auth/local_auth.dart';

class BiometricService {
  final LocalAuthentication _auth;

  BiometricService({LocalAuthentication? auth})
      : _auth = auth ?? LocalAuthentication();

  Future<bool> canCheckBiometrics() async {
    try {
      return await _auth.canCheckBiometrics;
    } catch (e) {
      debugPrint('BiometricService.canCheckBiometrics $e');
      return false;
    }
  }

  Future<bool> authenticate({String reason = 'Authentification requise'}) async {
    try {
      return await _auth.authenticate(
        localizedReason: reason,
        options: const AuthenticationOptions(biometricOnly: true),
      );
    } catch (e) {
      debugPrint('BiometricService.authenticate $e');
      return false;
    }
  }
}
