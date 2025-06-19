// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get home_title => 'Дом';

  @override
  String get settings_language => 'Язык';

  @override
  String get confirm => 'Подтверждать';

  @override
  String get cancel => 'Отмена';

  @override
  String get change_language_success => 'Язык успешно изменился';

  @override
  String get appTitle => 'AniSphère';

  @override
  String get mainScreenTitle => 'Дом';

  @override
  String get profile_incomplete_title => 'Неполный профиль';

  @override
  String get profile_incomplete_message =>
      'Обновите телефон, адрес или профессию.';

  @override
  String get profile_update_button => 'Обновить';

  @override
  String get identity_updated => 'Идентификация обновлена';

  @override
  String get identity_screen_title => 'Идентичность животного';

  @override
  String get microchip_label => 'Номер микрочипа';

  @override
  String get status_label => 'Статус';

  @override
  String get save_button => 'Сохранить';
}
