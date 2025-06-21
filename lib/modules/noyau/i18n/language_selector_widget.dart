// Widget preserved for future language selection features.
import 'package:flutter/material.dart';
import 'package:anisphere/l10n/app_localizations.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:provider/provider.dart';
import 'i18n_provider.dart';

/// Dropdown widget allowing users to switch application language.
/// Currently unused but kept for potential reactivation.
class LanguageSelectorWidget extends StatelessWidget {
  const LanguageSelectorWidget({super.key});

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
              child: Text(
                LocaleNames.of(context)!
                        .nameOf(locale.languageCode) ??
                    locale.languageCode,
              ),
            ),
          )
          .toList(),
    );
  }
}
