/// 📦 AniSphère – Essai Premium IA déclenché automatiquement
/// Vérifie si l’utilisateur gratuit est suffisamment actif.
/// Si l’IA locale connaît bien l’animal, propose un test gratuit de l’IA cloud.
/// 1 essai maximum. IA cloud activée automatiquement puis désactivée.
/// Rentabilisation progressive avec forte valeur perçue.
library;

import '../models/user_model.dart';
import '../models/user_profile_extension.dart';
import 'local_storage_service.dart';

class PremiumTrialManager {
  static const String _keyPrefix = 'premium_trial_';

  static UserProfileExtension _emptyExt() => const UserProfileExtension();

  static UserProfileExtension getExtension(String userId) {
    final json = LocalStorageService.get(_keyPrefix + userId);
    if (json is Map<String, dynamic>) {
      return UserProfileExtension.fromJson(Map<String, dynamic>.from(json));
    }
    return _emptyExt();
  }

  static Future<void> _saveExtension(
    String userId,
    UserProfileExtension ext,
  ) async {
    await LocalStorageService.set(_keyPrefix + userId, ext.toJson());
  }

  static Future<void> activateTrial(UserModel user, int durationDays) async {
    final until = DateTime.now().add(Duration(days: durationDays));
    final ext = getExtension(user.id).copyWith(
      premiumTrialUntil: until,
      hasUsedPremiumTrial: true,
    );
    await _saveExtension(user.id, ext);
    await LocalStorageService.saveUser(user.copyWith(iaPremium: true));
  }

  static Future<void> deactivateIfExpired(UserModel user) async {
    final ext = getExtension(user.id);
    if (ext.premiumTrialUntil != null &&
        ext.premiumTrialUntil!.isBefore(DateTime.now())) {
      await _saveExtension(user.id, ext.copyWith(premiumTrialUntil: null));
      await LocalStorageService.saveUser(user.copyWith(iaPremium: false));
    }
  }
}
