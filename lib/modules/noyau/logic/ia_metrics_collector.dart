/// Copilot Prompt : IAMetricsCollector collects and stores local AI metrics to be sent later to the cloud by CloudSyncService.
library;

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'ia_metrics_collector.g.dart';

@HiveType(typeId: 101)
class IAMetric {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final dynamic value;

  @HiveField(2)
  final DateTime timestamp;

  IAMetric({
    required this.name,
    required this.value,
    required this.timestamp,
  });
}

class IAMetricsCollector {
  static const String _boxName = "ia_metrics";

  /// 📥 Ajoute une métrique à la base locale
  static Future<void> addMetric(String name, dynamic value) async {
    final box = await Hive.openBox<IAMetric>(_boxName);
    final metric = IAMetric(
      name: name,
      value: value,
      timestamp: DateTime.now(),
    );
    await box.add(metric);
    debugPrint("📊 IAMetric enregistrée : $name = $value");
  }

  /// 📤 Récupère toutes les métriques collectées
  static Future<List<IAMetric>> getAllMetrics() async {
    final box = await Hive.openBox<IAMetric>(_boxName);
    return box.values.toList();
  }

  /// 🧹 Nettoie toutes les métriques collectées (après sync)
  static Future<void> clearMetrics() async {
    final box = await Hive.openBox<IAMetric>(_boxName);
    await box.clear();
    debugPrint("🧹 Toutes les IAMetrics ont été supprimées.");
  }
}
