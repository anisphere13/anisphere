library;

import 'package:flutter/foundation.dart';

import '../models/share_history_model.dart';
import 'share_history_service.dart';
import 'cloud_drive_service.dart';
import 'premium_sharing_checker.dart';

class CloudSharingService {
  final ShareHistoryService _historyService;
  final CloudDriveService _driveService;
  final PremiumSharingChecker _checker;

  CloudSharingService({
    ShareHistoryService? historyService,
    CloudDriveService? driveService,
    PremiumSharingChecker? checker,
  })  : _historyService = historyService ?? ShareHistoryService(),
        _driveService = driveService ?? CloudDriveService(),
        _checker = checker ?? PremiumSharingChecker();

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
