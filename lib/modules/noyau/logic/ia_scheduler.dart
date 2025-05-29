/// ⏰ IAScheduler — AniSphère
/// Déclenche l’exécution IA selon des règles temporelles ou événements clés
/// Utilise IAExecutor pour appliquer les décisions IA
/// Peut être déclenché automatiquement ou manuellement

library;

import 'dart:async';
import 'package:flutter/foundation.dart';

import 'ia_executor.dart';
import 'ia_master.dart';
import 'ia_context.dart';
import 'ia_logger.dart';
import 'ia_channel.dart';

class IAScheduler {
  final IAExecutor executor;
  final IAMaster iaMaster;

  Timer? _periodicTimer;
  DateTime? _lastExecution;

  IAScheduler({
    required this.executor,
    required this.iaMaster,
  });

  /// 🚀 Démarrage automatique du scheduler IA (à l'ouverture de l'app)
  void start(IAContext context) {
    _log("IAScheduler démarré.");
    _runIfNeeded(context);
    _periodicTimer = Timer.periodic(const Duration(hours: 6), (_) {
      _runIfNeeded(context);
    });
  }

  /// 🛑 Arrêt manuel (ex: logout)
  void stop() {
    _periodicTimer?.cancel();
    _periodicTimer = null;
    _log("IAScheduler arrêté manuellement.");
  }

  /// ⚡ Déclenchement IA immédiat (après action utilisateur clé)
  Future<void> triggerNow(IAContext context) async {
    _log("Déclenchement IA manuel (triggerNow).");
    await executor.executeAll(context);
    _lastExecution = DateTime.now();
  }

  /// 🔁 Déclenche IA seulement si plus de 6h depuis la dernière exécution
  Future<void> _runIfNeeded(IAContext context) async {
    final now = DateTime.now();
    if (_lastExecution == null || now.difference(_lastExecution!).inHours >= 6) {
      _log("Déclenchement automatique IA (toutes les 6h).");
      await executor.executeAll(context);
      _lastExecution = now;
    } else {
      _log("IA déjà exécutée récemment. Aucune action.");
    }
  }

  void _log(String message) {
    IALogger.log(
      channel: IAChannel.scheduler,
      message: message,
    );
    if (kDebugMode) debugPrint("🕒 $message");
  }
}
