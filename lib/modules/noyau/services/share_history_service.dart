
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import '../models/share_history_model.dart';

class ShareHistoryService {
  static const String boxName = 'share_history';
  Box<ShareHistoryModel>? _box;

  Future<void> _initHive() async {
    if (_box != null) return;
    if (!Hive.isAdapterRegistered(30)) {
      Hive.registerAdapter(ShareHistoryModelAdapter());
    }
    _box = Hive.isBoxOpen(boxName)
        ? Hive.box<ShareHistoryModel>(boxName)
        : await Hive.openBox<ShareHistoryModel>(boxName);
  }

  Future<void> addEntry(ShareHistoryModel entry) async {
    await _initHive();
    await _box?.add(entry);
    _log('Entrée ajoutée');
  }

  Future<List<ShareHistoryModel>> getEntries() async {
    await _initHive();
    return _box?.values.toList() ?? [];
  }

  void _log(String msg) {
    if (kDebugMode) {
      debugPrint('[ShareHistoryService] $msg');
    }
  }
}
