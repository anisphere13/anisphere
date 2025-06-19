/// 📦 AniSphère – Essai Premium IA déclenché automatiquement
/// Vérifie si l’utilisateur gratuit est suffisamment actif.
/// Si l’IA locale connaît bien l’animal, propose un test gratuit de l’IA cloud.
/// 1 essai maximum. IA cloud activée automatiquement puis désactivée.
/// Rentabilisation progressive avec forte valeur perçue.

import '../models/user_model.dart';
import '../models/animal_model.dart';
import '../services/notification_service.dart';

class PremiumTrialNotifier {
  static Future<void> notify(
    UserModel user,
    AnimalModel animal,
    int durationDays,
  ) async {
    final msg =
        'Nous avons suffisamment observé ${animal.name} pour lui proposer un suivi IA avancé gratuit.';
    await NotificationService.showNotification(
      title: 'Essai Premium disponible',
      body: msg,
    );
  }
}
