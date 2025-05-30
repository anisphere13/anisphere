/// 🧠 IAExecutor — AniSphère
/// Applique les décisions IA générées par `IAMaster`
/// Ce moteur exécute : nettoyage, notifications, sync, suggestions UI
/// Utilisé à l’accueil, au démarrage et lors des triggers IA
library;
import 'package:flutter/foundation.dart';

import 'ia_master.dart';
import 'ia_rule_engine.dart';
import 'ia_logger.dart';
import 'ia_context.dart';
import 'ia_channel.dart';
import 'ia_flag.dart';

import '../services/notification_service.dart';
import '../services/modules_service.dart';
import '../services/animal_service.dart';

class IAExecutor {
  final IAMaster iaMaster;
  final NotificationService notificationService;
  final ModulesService modulesService;
  final AnimalService animalService;

  IAExecutor({
    required this.iaMaster,
    required this.notificationService,
    required this.modulesService,
    required this.animalService,
  });

  /// 🔁 Exécute toutes les décisions IA disponibles (full pass)
  Future<void> executeAll(IAContext context) async {
    final List<String> actions = IARuleEngine.evaluate(context);

    for (final action in actions) {
      await _applyAction(action, context);
      IALogger.log(
        channel: IAChannel.execution,
        message: '✅ Action IA exécutée : $action',
      );
    }
  }

  /// 🧩 Applique une action IA
  Future<void> _applyAction(String action, IAContext context) async {
    switch (action) {
      case 'sync_animals':
        await animalService.syncAnimalsWithCloud?.call();
        break;

      case 'deactivate_unused_modules':
        await modulesService.deactivateUnusedModules?.call();
        break;

      case 'notify_identity_update_needed':
        await notificationService.sendLocalNotification?.call(
          title: 'Identité animale à mettre à jour',
          body: 'Une fiche identité n’a pas été actualisée depuis 12 mois.',
        );
        break;

      case 'show_ui_suggestion_card':
        IAMaster.instance.setFlag(IAFlag.showSuggestionCard, true);
        break;

      default:
        if (kDebugMode) {
          print('⚠️ Action IA inconnue : $action');
        }
        IALogger.log(
          channel: IAChannel.execution,
          message: '⚠️ Action inconnue ignorée : $action',
        );
        break;
    }
  }
}

