library;

import 'package:flutter/foundation.dart';

import '../models/share_history_model.dart';
import 'share_history_service.dart';

class LocalSharingService {
  final ShareHistoryService _historyService;

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
}
