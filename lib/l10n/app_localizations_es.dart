// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get home_title => 'Hogar';

  @override
  String get settings_language => 'Idioma';

  @override
  String get confirm => 'Confirmar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get change_language_success => 'El lenguaje cambió con éxito';

  @override
  String get appTitle => 'AniSphère';

  @override
  String get mainScreenTitle => 'Hogar';

  @override
  String get profile_incomplete_title => 'Perfil incompleto';

  @override
  String get profile_incomplete_message =>
      'Actualice su teléfono, dirección o profesión.';

  @override
  String get profile_update_button => 'Actualizar';

  @override
  String get identity_updated => 'Identidad actualizada';

  @override
  String get identity_screen_title => 'Identidad del animal';

  @override
  String get microchip_label => 'Número de chip';

  @override
  String get status_label => 'Estado';

  @override
  String get save_button => 'Guardar';
}
