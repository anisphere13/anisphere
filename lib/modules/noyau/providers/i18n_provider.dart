import 'package:flutter/material.dart';

/// Provides the current [Locale] of the app and allows switching it.
class I18nProvider extends ChangeNotifier {
  Locale _locale = const Locale('en');

  /// Current app locale.
  Locale get locale => _locale;

  /// Change the locale and notify listeners.
  void setLocale(Locale locale) {
    if (_locale == locale) return;
    _locale = locale;
    notifyListeners();
  }
}
