import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart' as l10n;

class AppLocalizations {
  static l10n.AppLocalizations of(BuildContext context) {
    return l10n.AppLocalizations.of(context)!;
  }

  static const LocalizationsDelegate<l10n.AppLocalizations> delegate =
      l10n.AppLocalizations.delegate;
}
