// Copilot Prompt : IAMetricsCollector collects and stores local AI metrics to be sent later to the cloud by CloudSyncService.
library;

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'ia_metrics_collector.g.dart';

@HiveType(typeId: 101)
class IAMetric {
  @HiveField(0)
  final String module;

  @HiveField(1)
  final String type;

  @HiveField(2)
  final String animalId;

  @HiveField(3)
  final String userId;

  @HiveField(4)
  final Map<String, dynamic>? data;

  @HiveField(5)
  final Map<String, dynamic>? metadata;

  @HiveField(6)
  final DateTime timestamp;

  IAMetric({
    required this.module,
    required this.type,
    required this.animalId,
    required this.userId,
    this.data,
    this.metadata,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();
}

class IAMetricsCollector {
  static const String _boxName = "ia_metrics";

  /// 📥 Ajoute un événement de module à la base locale
  static Future<void> _logModuleEvent({
    required String module,
    required String type,
    required String animalId,
    required String userId,
    Map<String, dynamic>? data,
    Map<String, dynamic>? metadata,
  }) async {
    final box = await Hive.openBox<IAMetric>(_boxName);
    final metric = IAMetric(
      module: module,
      type: type,
      animalId: animalId,
      userId: userId,
      data: data,
      metadata: metadata,
    );
    await box.add(metric);
    debugPrint("📊 IAMetric enregistrée : $module/$type for $animalId");
  }

  /// 🎓 Log d'un événement lié au module Éducation
  static Future<void> logEducationEvent({
    required String type,
    required String animalId,
    required String userId,
    Map<String, dynamic>? data,
    Map<String, dynamic>? metadata,
  }) async {
    await _logModuleEvent(
      module: 'education',
      type: type,
      animalId: animalId,
      userId: userId,
      data: data,
      metadata: metadata,
    );
  }

  /// 🐕‍🦺 Log d'un événement lié au module Dressage
  static Future<void> logDressageEvent({
    required String type,
    required String animalId,
    required String userId,
    Map<String, dynamic>? data,
    Map<String, dynamic>? metadata,
  }) async {
    await _logModuleEvent(
      module: 'dressage',
      type: type,
      animalId: animalId,
      userId: userId,
      data: data,
      metadata: metadata,
    );
  }

  /// 🏷️ Log d'un événement lié au module Identité
  static Future<void> logIdentityEvent({
    required String type,
    required String animalId,
    required String userId,
    Map<String, dynamic>? data,
    Map<String, dynamic>? metadata,
  }) async {
    await _logModuleEvent(
      module: 'identite',
      type: type,
      animalId: animalId,
      userId: userId,
      data: data,
      metadata: metadata,
    );
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
