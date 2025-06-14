library;

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';

import 'cgu_manager.dart';

part 'consent_service.g.dart';

@HiveType(typeId: 170)
class ConsentEntry {
  @HiveField(0)
  final String type;

  @HiveField(1)
  final String module;

  @HiveField(2)
  final String version;

  @HiveField(3)
  final String scope;

  @HiveField(4)
  final String cguVersion;

  @HiveField(5)
  final DateTime timestamp;

  const ConsentEntry({
    required this.type,
    required this.module,
    required this.version,
    required this.scope,
    required this.cguVersion,
    required this.timestamp,
  });
}

class ConsentService {
  static const _boxName = 'consents';
  static const _secureKeyName = 'hive_aes_key';
  static const _secureStorage = FlutterSecureStorage();

  static HiveAesCipher? _cipher;
  static Box<ConsentEntry>? _box;

  static Future<HiveAesCipher> _getCipher() async {
    if (_cipher != null) return _cipher!;
    final stored = await _secureStorage.read(key: _secureKeyName);
    List<int> key;
    if (stored == null) {
      key = Hive.generateSecureKey();
      await _secureStorage.write(key: _secureKeyName, value: base64UrlEncode(key));
    } else {
      key = base64Url.decode(stored);
    }
    _cipher = HiveAesCipher(key);
    return _cipher!;
  }

  static Future<Box<ConsentEntry>> _openBox() async {
    if (_box?.isOpen ?? false) return _box!;
    final cipher = await _getCipher();
    if (!Hive.isAdapterRegistered(ConsentEntryAdapter().typeId)) {
      Hive.registerAdapter(ConsentEntryAdapter());
    }
    _box = await Hive.openBox<ConsentEntry>(_boxName, encryptionCipher: cipher);
    return _box!;
  }

  /// Save a consent entry with the latest CGU version.
  static Future<void> recordConsent(
    String type,
    String module,
    String version,
    String scope,
  ) async {
    final box = await _openBox();
    final entry = ConsentEntry(
      type: type,
      module: module,
      version: version,
      scope: scope,
      cguVersion: CguManager.latestVersion,
      timestamp: DateTime.now(),
    );
    await box.put('${type}_$module', entry);
    debugPrint('✅ Consent recorded: $type - $module');
  }

  /// Check if consent exists for given type and module.
  static Future<bool> hasConsent(String type, String module) async {
    final box = await _openBox();
    final entry = box.get('${type}_$module');
    return entry != null && entry.cguVersion == CguManager.latestVersion;
  }

  /// Revoke consent and optionally delete related data.
  static Future<void> revokeConsent(
    String type,
    String module, {
    Future<void> Function()? onDelete,
  }) async {
    final box = await _openBox();
    await box.delete('${type}_$module');
    debugPrint('🚫 Consent revoked: $type - $module');
    if (onDelete != null) {
      await onDelete();
    }
  }
}

// TODO: ajouter test
