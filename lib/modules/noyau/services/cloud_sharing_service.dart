library;
// TODO: ajouter test

import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'cloud_sync_service.dart';

class CloudSharingService {
  final CloudSyncService _syncService;

  CloudSharingService({CloudSyncService? syncService})
      : _syncService = syncService ?? CloudSyncService();

  Future<void> uploadCompressed(List<int> gzipData) async {
    final encoded = base64Encode(gzipData);
    await _syncService.pushModuleData('sharing', {'data': encoded});
    debugPrint('☁️ Données de partage envoyées au cloud');
  }
}
