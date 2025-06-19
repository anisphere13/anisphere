// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get home_title => 'Home';

  @override
  String get settings_language => 'Language';

  @override
  String get confirm => 'Confirm';

  @override
  String get cancel => 'Cancel';

  @override
  String get change_language_success => 'Language changed successfully';

  @override
  String get appTitle => 'AniSphère';

  @override
  String get mainScreenTitle => 'Home';

  @override
  String get profile_incomplete_title => 'Profile incomplete';

  @override
  String get profile_incomplete_message =>
      'Please update your phone, address or profession.';

  @override
  String get profile_update_button => 'Update';
}
