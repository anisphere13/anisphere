// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get home_title => 'بيت';

  @override
  String get settings_language => 'لغة';

  @override
  String get confirm => 'يتأكد';

  @override
  String get cancel => 'يلغي';

  @override
  String get change_language_success => 'تغيرت اللغة بنجاح';

  @override
  String get appTitle => 'AniSphère';

  @override
  String get mainScreenTitle => 'بيت';

  @override
  String get profile_incomplete_title => 'الملف الشخصي غير مكتمل';

  @override
  String get profile_incomplete_message =>
      'يرجى تحديث الهاتف أو العنوان أو المهنة.';

  @override
  String get profile_update_button => 'تحديث';

  @override
  String get identity_updated => 'تم تحديث الهوية';

  @override
  String get identity_screen_title => 'هوية الحيوان';

  @override
  String get microchip_label => 'رقم الشريحة';

  @override
  String get status_label => 'الحالة';

  @override
  String get save_button => 'حفظ';
}
