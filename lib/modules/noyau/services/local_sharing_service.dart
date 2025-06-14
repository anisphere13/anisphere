library;
// TODO: ajouter test

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

class LocalSharingService {
  static const String _boxName = 'local_sharing_queue';

  Future<void> storeShare(Map<String, dynamic> data) async {
    final box = await Hive.openBox<Map>(_boxName);
    await box.add(data);
    debugPrint('📥 Donnée de partage stockée localement');
  }

  Future<List<Map<String, dynamic>>> getPendingShares() async {
    final box = await Hive.openBox<Map>(_boxName);
    return box.values.map((e) => Map<String, dynamic>.from(e)).toList();
  }

  Future<void> clear() async {
    final box = await Hive.openBox<Map>(_boxName);
    await box.clear();
  }
}
