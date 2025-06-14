// Service de gestion des versions CGU et Politique de confidentialité.
// Lit les versions depuis le stockage local ou Firebase Remote Config.
// Forcera l'affichage de LegalScreen si l'utilisateur n'a pas accepté
// la dernière version disponible.
library;

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'local_storage_service.dart';
import '../screens/legal_screen.dart';
import 'navigation_service.dart';

class CguManager {
  static const _acceptedCguKey = 'accepted_cgu_version';
  static const _acceptedPrivacyKey = 'accepted_privacy_version';

  static const _remoteCguKey = 'cgu_version';
  static const _remotePrivacyKey = 'privacy_version';

  final FirebaseRemoteConfig _remoteConfig;

  CguManager({FirebaseRemoteConfig? remoteConfig})
      : _remoteConfig = remoteConfig ?? FirebaseRemoteConfig.instance;

  Future<String> _getVersion(String remoteKey) async {
    try {
      await _remoteConfig.setDefaults({remoteKey: '1'});
      await _remoteConfig.fetchAndActivate();
      final value = _remoteConfig.getString(remoteKey);
      if (value.isNotEmpty) {
        await LocalStorageService.set(remoteKey, value);
        return value;
      }
    } catch (e) {
      debugPrint('❌ RemoteConfig $remoteKey: $e');
    }
    return LocalStorageService.get(remoteKey, defaultValue: '1') as String;
  }

  Future<String> get currentCguVersion => _getVersion(_remoteCguKey);
  Future<String> get currentPrivacyVersion => _getVersion(_remotePrivacyKey);

  Future<void> acceptCurrent() async {
    final cgu = await currentCguVersion;
    final privacy = await currentPrivacyVersion;
    await LocalStorageService.set(_acceptedCguKey, cgu);
    await LocalStorageService.set(_acceptedPrivacyKey, privacy);
  }

  Future<void> ensureLatestAccepted() async {
    final acceptedCgu =
        LocalStorageService.get(_acceptedCguKey, defaultValue: '') as String;
    final acceptedPrivacy =
        LocalStorageService.get(_acceptedPrivacyKey, defaultValue: '') as String;
    final cgu = await currentCguVersion;
    final privacy = await currentPrivacyVersion;

    if (acceptedCgu != cgu || acceptedPrivacy != privacy) {
      if (NavigationService.context != null) {
        await NavigationService.push(
          const LegalScreen(consentType: 'general'), // or an enum value
        );
      } else {
        debugPrint('❌ Navigation context indisponible pour LegalScreen');
      }
    }
  }
}
