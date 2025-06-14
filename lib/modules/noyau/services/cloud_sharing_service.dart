library;

import 'dart:io';

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

  /// Upload une donnée compressée en GZip vers le cloud.
  Future<void> uploadCompressed(List<int> gzipData) async {
    final tmp = File(
        '${Directory.systemTemp.path}/share_${DateTime.now().millisecondsSinceEpoch}.gz');
    await tmp.writeAsBytes(gzipData);
    await uploadFile(tmp, useWebDav: true);
    await tmp.delete();
  }

  /// Upload un fichier et retourne son URL si succès.
  Future<String?> uploadFile(File file, {bool useWebDav = false}) async {
    if (!_checker.canUseCloudSharing()) {
      return null;
    }
    try {
      final success = await _driveService.uploadFile(file);
      await _historyService.addEntry(
        ShareHistoryModel(
          mode: 'cloud_file',
          date: DateTime.now(),
          success: success,
        ),
      );
      if (success) {
        final name = file.uri.pathSegments.last;
        return 'https://example.com/$name';
      }
    } catch (e) {
      await _historyService.addEntry(
        ShareHistoryModel(
          mode: 'cloud_file',
          date: DateTime.now(),
          success: false,
          feedback: e.toString(),
        ),
      );
    }
    return null;
  }
}
