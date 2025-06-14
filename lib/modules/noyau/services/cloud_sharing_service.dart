library;

import 'package:flutter/foundation.dart';

import '../models/share_history_model.dart';
import 'share_history_service.dart';

class CloudSharingService {
  final ShareHistoryService _historyService;

  CloudSharingService({ShareHistoryService? historyService})
      : _historyService = historyService ?? ShareHistoryService();

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
}
