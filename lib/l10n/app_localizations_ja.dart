// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get home_title => '家';

  @override
  String get settings_language => '言語';

  @override
  String get confirm => '確認する';

  @override
  String get cancel => 'キャンセル';

  @override
  String get change_language_success => '言語は成功しました';
}
