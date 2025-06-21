// Service retained for potential future internationalization logic.
import 'package:flutter/material.dart';
import '../services/local_storage_service.dart';

/// Utility class to persist the selected locale.
class I18nService {
  static const _key = 'locale';

  static Locale getCurrentLocale() {
    final code = LocalStorageService.get(_key, defaultValue: 'en') as String;
    return Locale(code);
  }

  static Future<void> setLocale(Locale locale) async {
    await LocalStorageService.set(_key, locale.languageCode);
  }
}
