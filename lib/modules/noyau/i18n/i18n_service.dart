import 'package:flutter/material.dart';
import '../services/local_storage_service.dart';

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
