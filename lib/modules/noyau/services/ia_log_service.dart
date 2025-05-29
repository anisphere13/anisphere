/// 📄 ia_log_service.dart — Journal IA local AniSphère
/// Gère l’écriture, la lecture et la suppression des logs IA
/// Réservé aux super_admins (non visible utilisateur standard)
/// Utilisé par IALogViewer et pour le debug IA

library;

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'ia_log_service.g.dart';

@HiveType(typeId: 10)
class IALogEntry {
  @HiveField(0)
  final DateTime timestamp;

  @HiveField(1)
  final String type; // ex : info, warning, error, decision, suggestion

  @HiveField(2)
  final String message;

  @HiveField(3)
  final String? module; // optionnel : pour filtrer par module IA

  IALogEntry({
    required this.timestamp,
    required this.type,
    required this.message,
    this.module,
  });
}

class IALogService {
  static const String _logBoxName = 'ia_logs';
  static Box<IALogEntry>? _logBox;

  /// 📦 Initialise la boîte Hive (appelé une fois au démarrage si besoin)
  static Future<void> init() async {
    if (!Hive.isAdapterRegistered(10)) {
      Hive.registerAdapter(IALogEntryAdapter());
    }
    _logBox = Hive.isBoxOpen(_logBoxName)
        ? Hive.box<IALogEntry>(_logBoxName)
        : await Hive.openBox<IALogEntry>(_logBoxName);
  }

  /// 📝 Ajoute une entrée dans le journal IA
  static Future<void> addLog({
    required String type,
    required String message,
    String? module,
  }) async {
    try {
      await init();
      final entry = IALogEntry(
        timestamp: DateTime.now(),
        type: type,
        message: message,
        module: module,
      );
      await _logBox?.add(entry);
      if (kDebugMode) {
        debugPrint("🧠 [IA Log] $type | $message");
      }
    } catch (e) {
      // Log uniquement en debug
      assert(() {
        debugPrint("❌ Erreur ajout log IA : $e");
        return true;
      }());
    }
  }

  /// 📚 Récupère tous les logs (ordre décroissant)
  static Future<List<IALogEntry>> getLogs() async {
    try {
      await init();
      final logs = _logBox?.values.toList() ?? [];
      logs.sort((a, b) => b.timestamp.compareTo(a.timestamp));
      return logs;
    } catch (e) {
      // Log uniquement en debug
      assert(() {
        debugPrint("❌ Erreur récupération logs IA : $e");
        return true;
      }());
      return [];
    }
  }

  /// 🧼 Supprime tous les logs IA (admin uniquement)
  static Future<void> clearLogs() async {
    try {
      await init();
      await _logBox?.clear();
    } catch (e) {
      // Log uniquement en debug
      assert(() {
        debugPrint("❌ Erreur suppression logs IA : $e");
        return true;
      }());
    }
  }

  /// 🔍 Filtrage par module IA
  static Future<List<IALogEntry>> getLogsForModule(String module) async {
    final all = await getLogs();
    return all.where((e) => e.module == module).toList();
  }
}
