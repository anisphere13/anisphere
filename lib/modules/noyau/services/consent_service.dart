// Copilot Prompt : Service de gestion des consentements utilisateur.
// Stocke simplement chaque consentement dans LocalStorageService.
library;

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import '../models/consent_entry.dart';
import 'local_storage_service.dart';

class ConsentService {
  static const _boxName = 'consent_history';
  Box<ConsentEntry>? _box;

  Future<Box<ConsentEntry>> _openBox() async {
    if (_box?.isOpen ?? false) return _box!;
    if (!Hive.isAdapterRegistered(ConsentActionAdapter().typeId)) {
      Hive.registerAdapter(ConsentActionAdapter());
    }
    if (!Hive.isAdapterRegistered(ConsentEntryAdapter().typeId)) {
      Hive.registerAdapter(ConsentEntryAdapter());
    }
    _box = Hive.isBoxOpen(_boxName)
        ? Hive.box<ConsentEntry>(_boxName)
        : await Hive.openBox<ConsentEntry>(_boxName);
    return _box!;
  }

  /// Récupère l'historique complet des consentements.
  Future<List<ConsentEntry>> getHistory() async {
    final box = await _openBox();
    return box.values.toList();
  }

  /// Ajoute une entrée de consentement dans Hive.
  Future<void> addEntry(ConsentEntry entry) async {
    final box = await _openBox();
    await box.add(entry);
  }

  /// Vérifie si l'utilisateur a déjà donné son consentement pour [type].
  Future<bool> hasConsent(String type) async {
    final box = await _openBox();
    final entries = box.values.where((e) => e.id == type).toList();
    if (entries.isNotEmpty) {
      return entries.last.action == ConsentAction.accepted;
    }
    return LocalStorageService.getBool('consent_' '$type', defaultValue: false);
  }

  /// Enregistre le consentement de l'utilisateur pour [type].
  Future<void> saveConsent(String type) async {
    await LocalStorageService.set('consent_'
        '$type', true);
    await addEntry(
      ConsentEntry(
        id: type,
        userId: '',
        action: ConsentAction.accepted,
        timestamp: DateTime.now(),
      ),
    );
    debugPrint('🔐 Consentement enregistré pour $type');
  }
}
