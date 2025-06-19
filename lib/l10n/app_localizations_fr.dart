// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get home_title => 'Maison';

  @override
  String get settings_language => 'Langue';

  @override
  String get confirm => 'Confirmer';

  @override
  String get cancel => 'Annuler';

  @override
  String get change_language_success => 'La langue a changé avec succès';

  @override
  String get appTitle => 'AniSphère';

  @override
  String get mainScreenTitle => 'Maison';

  @override
  String get profile_incomplete_title => 'Profil incomplet';

  @override
  String get profile_incomplete_message =>
      'Mettez à jour votre téléphone, adresse ou profession.';

  @override
  String get profile_update_button => 'Mettre à jour';

  @override
  String get identity_updated => 'Identité mise à jour';

  @override
  String get identity_screen_title => 'Identité de l\u2019animal';

  @override
  String get microchip_label => 'Numéro de puce';

  @override
  String get status_label => 'Statut';

  @override
  String get save_button => 'Sauvegarder';
}
