import 'package:flutter/widgets.dart';
import 'package:anisphere/l10n/app_localizations.dart' as l10n;

class AppLocalizations {
  static l10n.AppLocalizations? of(BuildContext context) {
    return l10n.AppLocalizations.of(context);
  }

  static final LocalizationsDelegate<l10n.AppLocalizations> delegate =
      l10n.AppLocalizations.delegate;
}
