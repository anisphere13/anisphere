// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get home_title => 'Heim';

  @override
  String get settings_language => 'Sprache';

  @override
  String get confirm => 'Bestätigen';

  @override
  String get cancel => 'Stornieren';

  @override
  String get change_language_success => 'Die Sprache änderte sich erfolgreich';
}
