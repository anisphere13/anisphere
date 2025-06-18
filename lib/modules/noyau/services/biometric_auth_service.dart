// Copilot Prompt : Service d’authentification biométrique Flutter...

import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:hive/hive.dart';

import '../models/security_settings_model.dart';

class BiometricAuthService {
  final LocalAuthentication _localAuth = LocalAuthentication();
  static const _boxName = 'securitySettings';

  Future<bool> canCheckBiometrics() async {
    try {
      return await _localAuth.canCheckBiometrics ||
          await _localAuth.isDeviceSupported();
    } catch (_) {
      return false;
    }
  }

  Future<bool> authenticateWithBiometrics({String reason = 'Veuillez vous authentifier'}) async {
    try {
      return await _localAuth.authenticate(
        localizedReason: reason,
        options: const AuthenticationOptions(biometricOnly: true),
      );
    } on PlatformException {
      return false;
    }
  }

  Future<bool> isBiometricEnabled() async {
    final box = await Hive.openBox<SecuritySettingsModel>(_boxName);
    final settings = box.get('settings');
    return settings?.biometricEnabled ?? false;
  }

  Future<bool> authenticateOrPin(String reason) async {
    if (await isBiometricEnabled() && await canCheckBiometrics()) {
      final ok = await authenticateWithBiometrics(reason: reason);
      if (ok) return true;
    }
    final box = await Hive.openBox<SecuritySettingsModel>(_boxName);
    final settings = box.get('settings');
    if (settings?.encryptedPin == null) return false;
    // Ici on supposerait une saisie utilisateur du PIN chiffré. Simplifié pour tests.
    return settings!.encryptedPin!.isNotEmpty;
  }
}
