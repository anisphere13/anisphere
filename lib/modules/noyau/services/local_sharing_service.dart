library;

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../models/share_history_model.dart';
import 'share_history_service.dart';
import 'qr_service.dart';

class LocalSharingService {
  final ShareHistoryService _historyService;
  static const String _boxName = 'local_sharing_queue';

  LocalSharingService({ShareHistoryService? historyService})
      : _historyService = historyService ?? ShareHistoryService();

  Future<void> share(String data) async {
    try {
      debugPrint('📤 Partage local : $data');
      await _historyService.addEntry(
        ShareHistoryModel(
          mode: 'local',
          date: DateTime.now(),
          success: true,
        ),
      );
    } catch (e) {
      await _historyService.addEntry(
        ShareHistoryModel(
          mode: 'local',
          date: DateTime.now(),
          success: false,
          feedback: e.toString(),
        ),
      );
    }
  }

  /// Génère un QR code pour partager localement [data].
  Widget shareViaQR(String data) {
    return QRService.generateQRCode(data);
  }

  Future<Box<Map>> _openBox() async {
    if (Hive.isBoxOpen(_boxName)) {
      return Hive.box<Map>(_boxName);
    }
    return await Hive.openBox<Map>(_boxName);
  }

  /// Stocke un partage en attente d'envoi cloud.
  Future<void> storeShare(Map<String, dynamic> data) async {
    final box = await _openBox();
    await box.add(data);
  }

  /// Récupère les partages en attente.
  Future<List<Map<String, dynamic>>> getPendingShares() async {
    final box = await _openBox();
    return box.values
        .map((e) => Map<String, dynamic>.from(e as Map))
        .toList();
  }

  /// Vide la file de partage local.
  Future<void> clear() async {
    final box = await _openBox();
    await box.clear();
  }
}
