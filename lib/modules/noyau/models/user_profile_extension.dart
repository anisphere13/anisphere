/// 📦 AniSphère – Essai Premium IA déclenché automatiquement
/// Vérifie si l’utilisateur gratuit est suffisamment actif.
/// Si l’IA locale connaît bien l’animal, propose un test gratuit de l’IA cloud.
/// 1 essai maximum. IA cloud activée automatiquement puis désactivée.
/// Rentabilisation progressive avec forte valeur perçue.
library;

import 'package:hive/hive.dart';

part 'user_profile_extension.g.dart';

@HiveType(typeId: 92)
class UserProfileExtension {
  @HiveField(0)
  final DateTime? premiumTrialUntil;

  @HiveField(1)
  final bool hasUsedPremiumTrial;

  const UserProfileExtension({
    this.premiumTrialUntil,
    this.hasUsedPremiumTrial = false,
  });

  factory UserProfileExtension.fromJson(Map<String, dynamic> json) {
    return UserProfileExtension(
      premiumTrialUntil: json['premiumTrialUntil'] != null
          ? DateTime.tryParse(json['premiumTrialUntil'])
          : null,
      hasUsedPremiumTrial: json['hasUsedPremiumTrial'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        'premiumTrialUntil': premiumTrialUntil?.toIso8601String(),
        'hasUsedPremiumTrial': hasUsedPremiumTrial,
      };

  UserProfileExtension copyWith({
    DateTime? premiumTrialUntil,
    bool? hasUsedPremiumTrial,
  }) {
    return UserProfileExtension(
      premiumTrialUntil: premiumTrialUntil ?? this.premiumTrialUntil,
      hasUsedPremiumTrial: hasUsedPremiumTrial ?? this.hasUsedPremiumTrial,
    );
  }
}
