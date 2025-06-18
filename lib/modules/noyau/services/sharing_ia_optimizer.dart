
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';

import 'cloud_sharing_service.dart';
import 'local_sharing_service.dart';
import 'sharing_connectivity_manager.dart';

class SharingIaOptimizer {
  final CloudSharingService _cloudService;
  final LocalSharingService _localService;
  final SharingConnectivityManager _connectivity;
  final Set<int> _hashCache = {};
  StreamSubscription<SharingMode>? _sub;

  SharingIaOptimizer({
    CloudSharingService? cloudService,
    LocalSharingService? localService,
    SharingConnectivityManager? connectivity,
  })  : _cloudService = cloudService ?? CloudSharingService(),
        _localService = localService ?? LocalSharingService(),
        _connectivity = connectivity ?? SharingConnectivityManager();

  Future<void> init() async {
    await _connectivity.init();
    _sub = _connectivity.onModeChanged.listen((mode) {
      if (mode == SharingMode.cloudReady) {
        processPending();
      }
    });
  }

  Future<void> addData(Map<String, dynamic> data) async {
    final jsonStr = jsonEncode(data);
    final hash = jsonStr.hashCode;
    if (_hashCache.contains(hash)) {
      debugPrint('⚠️ Donnée en double ignorée');
      return;
    }
    _hashCache.add(hash);
    await _localService.storeShare(data);
    if (_connectivity.mode == SharingMode.cloudReady) {
      await processPending();
    }
  }

  Future<void> processPending() async {
    final entries = await _localService.getPendingShares();
    for (final entry in entries) {
      final compressed = gzip.encode(utf8.encode(jsonEncode(entry)));
      await _cloudService.uploadCompressed(compressed);
    }
    await _localService.clear();
  }

  void dispose() {
    _sub?.cancel();
    _connectivity.dispose();
  }
}
