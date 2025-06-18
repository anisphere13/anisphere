import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

/// Service minimal de gestion de la langue (stockage local Hive).
class I18nService {
  static const String boxName = 'settings';
  static const String localeKey = 'locale';

  final Box<dynamic> _box;

  I18nService({Box<dynamic>? testBox}) : _box = testBox ?? Hive.box<dynamic>(boxName);

  /// Sauvegarde la locale choisie
  Future<void> saveLocale(String locale) async {
    try {
      await _box.put(localeKey, locale);
      debugPrint('✅ Locale sauvegardée : $locale');
    } catch (e) {
      debugPrint('❌ Erreur saveLocale : $e');
    }
  }

  /// Charge la locale enregistrée
  String? loadLocale() {
    try {
      return _box.get(localeKey) as String?;
    } catch (e) {
      debugPrint('❌ Erreur loadLocale : $e');
      return null;
    }
  }
}
