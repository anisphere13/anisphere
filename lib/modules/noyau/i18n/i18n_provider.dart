// Provider kept for potential multi-language support in the future.
import 'package:flutter/material.dart';
import 'i18n_service.dart';

/// Currently unused language provider.
class I18nProvider extends ChangeNotifier {
  Locale _locale = I18nService.getCurrentLocale();

  Locale get locale => _locale;

  Future<void> load() async {
    _locale = I18nService.getCurrentLocale();
    notifyListeners();
  }

  Future<void> setLocale(Locale locale) async {
    _locale = locale;
    await I18nService.setLocale(locale);
    notifyListeners();
  }
}
