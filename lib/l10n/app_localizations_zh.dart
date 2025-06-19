// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get home_title => '家';

  @override
  String get settings_language => '语言';

  @override
  String get confirm => '确认';

  @override
  String get cancel => '取消';

  @override
  String get change_language_success => '语言成功改变了';

  @override
  String get appTitle => 'AniSphère';

  @override
  String get mainScreenTitle => '家';

  @override
  String get profile_incomplete_title => '资料不完整';

  @override
  String get profile_incomplete_message => '请更新电话、地址或职业。';

  @override
  String get profile_update_button => '更新';
}
