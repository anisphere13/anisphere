// Copilot Prompt : Vérifie si l'utilisateur peut utiliser le partage cloud.

import '../providers/user_provider.dart';

class PremiumSharingChecker {
  final UserProvider? _userProvider;

  PremiumSharingChecker({UserProvider? userProvider})
      : _userProvider = userProvider;

  /// 💎 Retourne true si l'utilisateur actuel a accès au partage cloud.
  bool canUseCloudSharing() {
    final user = _userProvider?.user;
    return user?.iaPremium ?? false;
  }
}
