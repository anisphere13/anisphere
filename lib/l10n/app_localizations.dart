import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('it'),
    Locale('ja'),
    Locale('pt'),
    Locale('ru'),
    Locale('zh')
  ];

  /// No description provided for @home_title.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home_title;

  /// No description provided for @settings_language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settings_language;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @change_language_success.
  ///
  /// In en, this message translates to:
  /// **'Language changed successfully'**
  String get change_language_success;

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'AniSphère'**
  String get appTitle;

  /// No description provided for @mainScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get mainScreenTitle;

  /// No description provided for @profile_incomplete_title.
  ///
  /// In en, this message translates to:
  /// **'Profile incomplete'**
  String get profile_incomplete_title;

  /// No description provided for @profile_incomplete_message.
  ///
  /// In en, this message translates to:
  /// **'Please update your phone, address or profession.'**
  String get profile_incomplete_message;

  /// No description provided for @profile_update_button.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get profile_update_button;

  /// No description provided for @genealogy_title.
  ///
  /// In en, this message translates to:
  /// **'Genealogy'**
  String get genealogy_title;

  /// No description provided for @genealogy_screen_text.
  ///
  /// In en, this message translates to:
  /// **'Genealogy Screen'**
  String get genealogy_screen_text;

  /// No description provided for @father.
  ///
  /// In en, this message translates to:
  /// **'Father'**
  String get father;

  /// No description provided for @mother.
  ///
  /// In en, this message translates to:
  /// **'Mother'**
  String get mother;

  /// No description provided for @breeder_affixe.
  ///
  /// In en, this message translates to:
  /// **'Affix'**
  String get breeder_affixe;

  /// No description provided for @litter_number.
  ///
  /// In en, this message translates to:
  /// **'Litter Number'**
  String get litter_number;

  /// No description provided for @lof_name.
  ///
  /// In en, this message translates to:
  /// **'LOF Name'**
  String get lof_name;

  /// No description provided for @identity_public_profile_title.
  ///
  /// In en, this message translates to:
  /// **'Public Profile'**
  String get identity_public_profile_title;

  /// No description provided for @identity_summary_title.
  ///
  /// In en, this message translates to:
  /// **'Identity'**
  String get identity_summary_title;

  /// No description provided for @breeder_section_title.
  ///
  /// In en, this message translates to:
  /// **'Breeder'**
  String get breeder_section_title;

  /// No description provided for @microchip_number.
  ///
  /// In en, this message translates to:
  /// **'Microchip'**
  String get microchip_number;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @legal_status.
  ///
  /// In en, this message translates to:
  /// **'Legal status'**
  String get legal_status;

  /// No description provided for @identity_updated.
  ///
  /// In en, this message translates to:
  /// **'Identity updated'**
  String get identity_updated;

  /// No description provided for @identity_screen_title.
  ///
  /// In en, this message translates to:
  /// **'Identity'**
  String get identity_screen_title;

  /// No description provided for @microchip_label.
  ///
  /// In en, this message translates to:
  /// **'Microchip number'**
  String get microchip_label;

  /// No description provided for @status_label.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status_label;

  /// No description provided for @save_button.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save_button;

  /// No description provided for @identityModuleTitle.
  ///
  /// In en, this message translates to:
  /// **'Identity'**
  String get identityModuleTitle;

  /// No description provided for @identityModuleDescription.
  ///
  /// In en, this message translates to:
  /// **'Manage your animal\'s identity'**
  String get identityModuleDescription;

  /// No description provided for @settings_title.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings_title;

  /// No description provided for @backup_success.
  ///
  /// In en, this message translates to:
  /// **'Backup completed successfully.'**
  String get backup_success;

  /// No description provided for @backup_error.
  ///
  /// In en, this message translates to:
  /// **'Error during backup.'**
  String get backup_error;

  /// No description provided for @restore_success.
  ///
  /// In en, this message translates to:
  /// **'Restore successful.'**
  String get restore_success;

  /// No description provided for @restore_error.
  ///
  /// In en, this message translates to:
  /// **'Error during restore.'**
  String get restore_error;

  /// No description provided for @ai_score.
  ///
  /// In en, this message translates to:
  /// **'AI score'**
  String get ai_score;

  /// No description provided for @badge_state.
  ///
  /// In en, this message translates to:
  /// **'Badge'**
  String get badge_state;

  /// No description provided for @timeline_photos.
  ///
  /// In en, this message translates to:
  /// **'Timeline photos'**
  String get timeline_photos;

  /// No description provided for @import_icad.
  ///
  /// In en, this message translates to:
  /// **'Express I-CAD import'**
  String get import_icad;

  /// No description provided for @import_pdf.
  ///
  /// In en, this message translates to:
  /// **'Import PDF'**
  String get import_pdf;

  /// No description provided for @duplicate_alert.
  ///
  /// In en, this message translates to:
  /// **'Possible duplicate detected'**
  String get duplicate_alert;

  /// No description provided for @identity_onboarding_message.
  ///
  /// In en, this message translates to:
  /// **'Manage your animal identity here. Swipe to change animal.'**
  String get identity_onboarding_message;

  /// No description provided for @breeder_name.
  ///
  /// In en, this message translates to:
  /// **'Breeder name'**
  String get breeder_name;

  /// No description provided for @breeder_email.
  ///
  /// In en, this message translates to:
  /// **'Breeder email'**
  String get breeder_email;

  /// No description provided for @breeder_phone.
  ///
  /// In en, this message translates to:
  /// **'Breeder phone'**
  String get breeder_phone;

  /// No description provided for @onboarding_title.
  ///
  /// In en, this message translates to:
  /// **'Welcome to AniSphère'**
  String get onboarding_title;

  /// No description provided for @onboarding_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Let\'s set up your animal'**
  String get onboarding_subtitle;

  /// No description provided for @onboarding_skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get onboarding_skip;

  /// No description provided for @onboarding_next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get onboarding_next;

  /// No description provided for @duplicate_animal_warning.
  ///
  /// In en, this message translates to:
  /// **'Animal already exists'**
  String get duplicate_animal_warning;

  /// No description provided for @duplicate_photo_warning.
  ///
  /// In en, this message translates to:
  /// **'Photo already exists'**
  String get duplicate_photo_warning;

  /// No description provided for @photo_timeline_title.
  ///
  /// In en, this message translates to:
  /// **'Photo Timeline'**
  String get photo_timeline_title;

  /// No description provided for @identitiesRegistered.
  ///
  /// In en, this message translates to:
  /// **'identities registered'**
  String get identitiesRegistered;

  /// No description provided for @noHealthTracking.
  ///
  /// In en, this message translates to:
  /// **'No health tracking in progress'**
  String get noHealthTracking;

  /// No description provided for @healthTrackingSummary.
  ///
  /// In en, this message translates to:
  /// **'animals tracked for health'**
  String get healthTrackingSummary;

  /// No description provided for @noTrainingStarted.
  ///
  /// In en, this message translates to:
  /// **'No training started'**
  String get noTrainingStarted;

  /// No description provided for @trainingInProgress.
  ///
  /// In en, this message translates to:
  /// **'animals in training'**
  String get trainingInProgress;

  /// No description provided for @trainingAvailableFor.
  ///
  /// In en, this message translates to:
  /// **'Training available for'**
  String get trainingAvailableFor;

  /// No description provided for @noAnimalForTraining.
  ///
  /// In en, this message translates to:
  /// **'No animal registered for training'**
  String get noAnimalForTraining;

  /// No description provided for @aiSummaryUndefined.
  ///
  /// In en, this message translates to:
  /// **'AI summary not defined'**
  String get aiSummaryUndefined;

  /// No description provided for @noActiveModule.
  ///
  /// In en, this message translates to:
  /// **'No active module'**
  String get noActiveModule;

  /// No description provided for @share_title.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share_title;

  /// No description provided for @modules_title.
  ///
  /// In en, this message translates to:
  /// **'Modules'**
  String get modules_title;

  /// No description provided for @myAnimals_title.
  ///
  /// In en, this message translates to:
  /// **'My Animals'**
  String get myAnimals_title;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
        'ar',
        'de',
        'en',
        'es',
        'fr',
        'it',
        'ja',
        'pt',
        'ru',
        'zh'
      ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'it':
      return AppLocalizationsIt();
    case 'ja':
      return AppLocalizationsJa();
    case 'pt':
      return AppLocalizationsPt();
    case 'ru':
      return AppLocalizationsRu();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
