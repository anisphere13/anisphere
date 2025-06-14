library;

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import '../models/consent_entry.dart';

class ConsentService {
  static const String consentBoxName = 'consent_history';
  Box<ConsentEntry>? _box;
  final bool skipHiveInit;

  ConsentService({Box<ConsentEntry>? testBox, this.skipHiveInit = false}) {
    if (testBox != null) _box = testBox;
  }

  Future<void> init() async {
    await _initHive();
  }

  Future<void> _initHive() async {
    if (skipHiveInit || _box != null) return;
    try {
      _box = Hive.isBoxOpen(consentBoxName)
          ? Hive.box<ConsentEntry>(consentBoxName)
          : await Hive.openBox<ConsentEntry>(consentBoxName);
      _log('📦 Boîte consent initialisée');
    } catch (e) {
      _log('❌ Erreur init Hive consent : $e');
    }
  }

  Future<void> addEntry(ConsentEntry entry) async {
    try {
      await _initHive();
      await _box?.put(entry.id, entry);
    } catch (e) {
      _log('❌ Erreur addEntry : $e');
    }
  }

  Future<List<ConsentEntry>> getHistory() async {
    try {
      await _initHive();
      return _box?.values.toList() ?? [];
    } catch (e) {
      _log('❌ Erreur getHistory : $e');
      return [];
    }
  }

  void _log(String m) {
    if (kDebugMode) {
      debugPrint('[ConsentService] $m');
    }
  }
}
