library;

import 'dart:convert';
import 'package:flutter/foundation.dart';

import '../models/share_history_model.dart';
import 'share_history_service.dart';
import 'cloud_sync_service.dart';

class CloudSharingService {
  final ShareHistoryService _historyService;
  final CloudSyncService _syncService;

  CloudSharingService({
    ShareHistoryService? historyService,
    CloudSyncService? syncService,
  })  : _historyService = historyService ?? ShareHistoryService(),
        _syncService = syncService ?? CloudSyncService();

  Future<void> share(String data, {double cost = 0}) async {
    try {
      debugPrint('☁️ Partage cloud : $data');
      await _historyService.addEntry(
        ShareHistoryModel(
          mode: 'cloud',
          date: DateTime.now(),
          success: true,
          cost: cost,
        ),
      );
    } catch (e) {
      await _historyService.addEntry(
        ShareHistoryModel(
          mode: 'cloud',
          date: DateTime.now(),
          success: false,
          cost: cost,
          feedback: e.toString(),
        ),
      );
    }
  }

  Future<void> uploadCompressed(List<int> gzipData, {double cost = 0}) async {
    try {
      final encoded = base64Encode(gzipData);
      await _syncService.pushModuleData('sharing', {'data': encoded});
      await _historyService.addEntry(
        ShareHistoryModel(
          mode: 'cloud',
          date: DateTime.now(),
          success: true,
          cost: cost,
        ),
      );
      debugPrint('☁️ Données compressées envoyées au cloud');
    } catch (e) {
      await _historyService.addEntry(
        ShareHistoryModel(
          mode: 'cloud',
          date: DateTime.now(),
          success: false,
          cost: cost,
          feedback: e.toString(),
        ),
      );
      debugPrint('❌ [CloudShare] Upload compressed failed: $e');
    }
  }
}
