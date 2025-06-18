import 'package:flutter/material.dart';
import 'package:anisphere/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'i18n_provider.dart';

/// Dropdown widget allowing users to switch application language.
class LanguageSelectorWidget extends StatelessWidget {
  const LanguageSelectorWidget({super.key});

  String _nativeName(Locale locale) {
    switch (locale.languageCode) {
      case 'fr':
        return 'Français';
      case 'en':
        return 'English';
      default:
        return locale.languageCode;
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<I18nProvider>();
    return DropdownButton<Locale>(
      value: provider.locale,
      onChanged: (Locale? newLocale) {
        if (newLocale != null) {
          context.read<I18nProvider>().setLocale(newLocale);
        }
      },
      items: AppLocalizations.supportedLocales
          .map(
            (locale) => DropdownMenuItem<Locale>(
              value: locale,
              child: Text(_nativeName(locale)),
            ),
          )
          .toList(),
    );
  }
}
