import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_pt.dart';

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
    Locale('en'),
    Locale('pt'),
  ];

  /// No description provided for @movements.
  ///
  /// In en, this message translates to:
  /// **'Movements'**
  String get movements;

  /// No description provided for @emptyMovements.
  ///
  /// In en, this message translates to:
  /// **'Empty Movements'**
  String get emptyMovements;

  /// No description provided for @youDonTHaveMovements.
  ///
  /// In en, this message translates to:
  /// **'You don\'t have any movements for {month}'**
  String youDonTHaveMovements(Object month);

  /// No description provided for @totalIncome.
  ///
  /// In en, this message translates to:
  /// **'Total Income'**
  String get totalIncome;

  /// No description provided for @totalExpense.
  ///
  /// In en, this message translates to:
  /// **'Total Expense'**
  String get totalExpense;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @incomeExpense.
  ///
  /// In en, this message translates to:
  /// **'Income Expense'**
  String get incomeExpense;

  /// No description provided for @expense.
  ///
  /// In en, this message translates to:
  /// **'Expense'**
  String get expense;

  /// No description provided for @income.
  ///
  /// In en, this message translates to:
  /// **'Income'**
  String get income;

  /// No description provided for @expenseDescription.
  ///
  /// In en, this message translates to:
  /// **'Expense Description'**
  String get expenseDescription;

  /// No description provided for @expenseDescriptionHint.
  ///
  /// In en, this message translates to:
  /// **'Ex: Invoice Credit Card'**
  String get expenseDescriptionHint;

  /// No description provided for @descriptionCannotBeEmpty.
  ///
  /// In en, this message translates to:
  /// **'Description cannot be empty.'**
  String get descriptionCannotBeEmpty;

  /// No description provided for @amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount;

  /// No description provided for @amountHint.
  ///
  /// In en, this message translates to:
  /// **'Ex: \$150.00'**
  String get amountHint;

  /// No description provided for @amountDescription.
  ///
  /// In en, this message translates to:
  /// **'Amount per month'**
  String get amountDescription;

  /// No description provided for @amountEmptyValue.
  ///
  /// In en, this message translates to:
  /// **'Please type some value.'**
  String get amountEmptyValue;

  /// No description provided for @dueDayExpense.
  ///
  /// In en, this message translates to:
  /// **'Due day of expense'**
  String get dueDayExpense;

  /// No description provided for @dueDayIsRequired.
  ///
  /// In en, this message translates to:
  /// **'Due day is required'**
  String get dueDayIsRequired;

  /// No description provided for @dueDayExpenseHint.
  ///
  /// In en, this message translates to:
  /// **'Ex: 10'**
  String get dueDayExpenseHint;

  /// No description provided for @periodOfExpense.
  ///
  /// In en, this message translates to:
  /// **'Period of expense'**
  String get periodOfExpense;

  /// No description provided for @periodOfExpenseDescription.
  ///
  /// In en, this message translates to:
  /// **'If has not end date, pick the start date.'**
  String get periodOfExpenseDescription;

  /// No description provided for @startDateOrRangeIsRequired.
  ///
  /// In en, this message translates to:
  /// **'Start or range of dates is required.'**
  String get startDateOrRangeIsRequired;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @incomeDescription.
  ///
  /// In en, this message translates to:
  /// **'Income Description'**
  String get incomeDescription;

  /// No description provided for @incomeHint.
  ///
  /// In en, this message translates to:
  /// **'Ex: Salary'**
  String get incomeHint;

  /// No description provided for @incomeDay.
  ///
  /// In en, this message translates to:
  /// **'Income Day'**
  String get incomeDay;

  /// No description provided for @incomeDayIsRequired.
  ///
  /// In en, this message translates to:
  /// **'Income Day is required'**
  String get incomeDayIsRequired;

  /// No description provided for @periodOfIncome.
  ///
  /// In en, this message translates to:
  /// **'Period of income'**
  String get periodOfIncome;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @currency.
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get currency;

  /// No description provided for @selectCurrency.
  ///
  /// In en, this message translates to:
  /// **'Select a currency'**
  String get selectCurrency;

  /// No description provided for @americanDollar.
  ///
  /// In en, this message translates to:
  /// **'American Dollar'**
  String get americanDollar;

  /// No description provided for @euro.
  ///
  /// In en, this message translates to:
  /// **'Euro'**
  String get euro;

  /// No description provided for @brazilianReal.
  ///
  /// In en, this message translates to:
  /// **'Brazilian Real'**
  String get brazilianReal;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @portuguese.
  ///
  /// In en, this message translates to:
  /// **'Portuguese'**
  String get portuguese;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @system.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get system;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// No description provided for @dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @changesWasUpdated.
  ///
  /// In en, this message translates to:
  /// **'Successfull updated'**
  String get changesWasUpdated;

  /// No description provided for @occurrences.
  ///
  /// In en, this message translates to:
  /// **'Update Occurrences'**
  String get occurrences;

  /// No description provided for @updateJustIt.
  ///
  /// In en, this message translates to:
  /// **'Just it'**
  String get updateJustIt;

  /// No description provided for @updateAppOccurrences.
  ///
  /// In en, this message translates to:
  /// **'All occurrences'**
  String get updateAppOccurrences;

  /// No description provided for @youMustPickAnOption.
  ///
  /// In en, this message translates to:
  /// **'Você precisa escolher uma opção'**
  String get youMustPickAnOption;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @imageLink.
  ///
  /// In en, this message translates to:
  /// **'Image link'**
  String get imageLink;

  /// No description provided for @addLinkImage.
  ///
  /// In en, this message translates to:
  /// **'Add image a image link'**
  String get addLinkImage;

  /// No description provided for @appleSignIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Apple'**
  String get appleSignIn;

  /// No description provided for @googleSignIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Google'**
  String get googleSignIn;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get signOut;

  /// No description provided for @refresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get refresh;

  /// No description provided for @somethingWrong.
  ///
  /// In en, this message translates to:
  /// **'Something Wrong'**
  String get somethingWrong;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get tryAgain;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
