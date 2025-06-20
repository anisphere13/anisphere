// TODO: ajouter test

import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'cloud_sync_service.dart';

enum SharingMode { offline, localOnly, cloudReady }

class SharingConnectivityManager {
  final Connectivity _connectivity;
  final CloudSyncService _cloudSyncService;

  late final StreamSubscription<List<ConnectivityResult>> _sub;
  final StreamController<SharingMode> _controller = StreamController.broadcast();

  SharingMode _mode = SharingMode.offline;
  SharingMode get mode => _mode;
  Stream<SharingMode> get onModeChanged => _controller.stream;

  SharingConnectivityManager({
    Connectivity? connectivity,
    CloudSyncService? cloudSyncService,
  })  : _connectivity = connectivity ?? Connectivity(),
        _cloudSyncService = cloudSyncService ?? CloudSyncService();

  Future<void> init() async {
    final results = await _connectivity.checkConnectivity();
    _updateMode(results);
    _sub = _connectivity.onConnectivityChanged.listen(_updateMode);
  }

  void _updateMode(List<ConnectivityResult> results) {
    final connected = results.any((r) => r != ConnectivityResult.none);
    final wifi = results.contains(ConnectivityResult.wifi);
    final newMode = !connected
        ? SharingMode.offline
        : wifi
            ? SharingMode.cloudReady
            : SharingMode.localOnly;
    if (newMode != _mode) {
      _mode = newMode;
      _controller.add(_mode);
      if (_mode == SharingMode.cloudReady) {
        _cloudSyncService.replayOfflineTasks();
      }
    }
  }

  void dispose() {
    _sub.cancel();
    _controller.close();
  }
}
