/// 📦 AniSphère – Essai Premium IA déclenché automatiquement
/// Vérifie si l’utilisateur gratuit est suffisamment actif.
/// Si l’IA locale connaît bien l’animal, propose un test gratuit de l’IA cloud.
/// 1 essai maximum. IA cloud activée automatiquement puis désactivée.
/// Rentabilisation progressive avec forte valeur perçue.
library;

import '../models/user_model.dart';
import '../models/animal_model.dart';
import '../services/premium_trial_manager.dart';
import '../notifications/premium_trial_notifier.dart';

class PremiumTrialTrigger {
  static bool isEligible(UserModel user, AnimalModel animal) {
    final stats = animalStats(animal.id);
    return !user.iaPremium &&
        !PremiumTrialManager.getExtension(user.id).hasUsedPremiumTrial &&
        stats.sessionsCount >= 20 &&
        stats.activeDays >= 90 &&
        stats.videoAnalyses >= 5 &&
        stats.profileCompletenessScore > 75;
  }

  static Future<void> check(UserModel user, AnimalModel animal) async {
    if (isEligible(user, animal)) {
      final duration = computeTrialDuration(user, animal);
      await PremiumTrialManager.activateTrial(user, duration);
      await PremiumTrialNotifier.notify(user, animal, duration);
    }
  }
}

class AnimalUsageStats {
  final int sessionsCount;
  final int activeDays;
  final int videoAnalyses;
  final double profileCompletenessScore;

  const AnimalUsageStats({
    required this.sessionsCount,
    required this.activeDays,
    required this.videoAnalyses,
    required this.profileCompletenessScore,
  });
}

AnimalUsageStats animalStats(String animalId) {
  // TODO: récupérer les vraies métriques locales depuis IAMetricsCollector
  return const AnimalUsageStats(
    sessionsCount: 20,
    activeDays: 90,
    videoAnalyses: 5,
    profileCompletenessScore: 80,
  );
}

int computeTrialDuration(UserModel user, AnimalModel animal) {
  final stats = animalStats(animal.id);
  return stats.activeDays > 180 ? 60 : 30;
}
