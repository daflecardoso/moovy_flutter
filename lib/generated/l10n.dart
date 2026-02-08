// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Movements`
  String get movements {
    return Intl.message('Movements', name: 'movements', desc: '', args: []);
  }

  /// `Empty Movements`
  String get emptyMovements {
    return Intl.message(
      'Empty Movements',
      name: 'emptyMovements',
      desc: '',
      args: [],
    );
  }

  /// `You don't have any movements for {month}`
  String youDonTHaveMovements(Object month) {
    return Intl.message(
      'You don\'t have any movements for $month',
      name: 'youDonTHaveMovements',
      desc: '',
      args: [month],
    );
  }

  /// `Total Income`
  String get totalIncome {
    return Intl.message(
      'Total Income',
      name: 'totalIncome',
      desc: '',
      args: [],
    );
  }

  /// `Total Expense`
  String get totalExpense {
    return Intl.message(
      'Total Expense',
      name: 'totalExpense',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get total {
    return Intl.message('Total', name: 'total', desc: '', args: []);
  }

  /// `Income Expense`
  String get incomeExpense {
    return Intl.message(
      'Income Expense',
      name: 'incomeExpense',
      desc: '',
      args: [],
    );
  }

  /// `Expense`
  String get expense {
    return Intl.message('Expense', name: 'expense', desc: '', args: []);
  }

  /// `Income`
  String get income {
    return Intl.message('Income', name: 'income', desc: '', args: []);
  }

  /// `Expense Description`
  String get expenseDescription {
    return Intl.message(
      'Expense Description',
      name: 'expenseDescription',
      desc: '',
      args: [],
    );
  }

  /// `Ex: Invoice Credit Card`
  String get expenseDescriptionHint {
    return Intl.message(
      'Ex: Invoice Credit Card',
      name: 'expenseDescriptionHint',
      desc: '',
      args: [],
    );
  }

  /// `Description cannot be empty.`
  String get descriptionCannotBeEmpty {
    return Intl.message(
      'Description cannot be empty.',
      name: 'descriptionCannotBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Amount`
  String get amount {
    return Intl.message('Amount', name: 'amount', desc: '', args: []);
  }

  /// `Ex: $150.00`
  String get amountHint {
    return Intl.message('Ex: \$150.00', name: 'amountHint', desc: '', args: []);
  }

  /// `Amount per month`
  String get amountDescription {
    return Intl.message(
      'Amount per month',
      name: 'amountDescription',
      desc: '',
      args: [],
    );
  }

  /// `Please type some value.`
  String get amountEmptyValue {
    return Intl.message(
      'Please type some value.',
      name: 'amountEmptyValue',
      desc: '',
      args: [],
    );
  }

  /// `Due day of expense`
  String get dueDayExpense {
    return Intl.message(
      'Due day of expense',
      name: 'dueDayExpense',
      desc: '',
      args: [],
    );
  }

  /// `Due day is required`
  String get dueDayIsRequired {
    return Intl.message(
      'Due day is required',
      name: 'dueDayIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Ex: 10`
  String get dueDayExpenseHint {
    return Intl.message(
      'Ex: 10',
      name: 'dueDayExpenseHint',
      desc: '',
      args: [],
    );
  }

  /// `Period of expense`
  String get periodOfExpense {
    return Intl.message(
      'Period of expense',
      name: 'periodOfExpense',
      desc: '',
      args: [],
    );
  }

  /// `If has not end date, pick the start date.`
  String get periodOfExpenseDescription {
    return Intl.message(
      'If has not end date, pick the start date.',
      name: 'periodOfExpenseDescription',
      desc: '',
      args: [],
    );
  }

  /// `Start or range of dates is required.`
  String get startDateOrRangeIsRequired {
    return Intl.message(
      'Start or range of dates is required.',
      name: 'startDateOrRangeIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message('Save', name: 'save', desc: '', args: []);
  }

  /// `Delete`
  String get delete {
    return Intl.message('Delete', name: 'delete', desc: '', args: []);
  }

  /// `Income Description`
  String get incomeDescription {
    return Intl.message(
      'Income Description',
      name: 'incomeDescription',
      desc: '',
      args: [],
    );
  }

  /// `Ex: Salary`
  String get incomeHint {
    return Intl.message('Ex: Salary', name: 'incomeHint', desc: '', args: []);
  }

  /// `Income Day`
  String get incomeDay {
    return Intl.message('Income Day', name: 'incomeDay', desc: '', args: []);
  }

  /// `Income Day is required`
  String get incomeDayIsRequired {
    return Intl.message(
      'Income Day is required',
      name: 'incomeDayIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Period of income`
  String get periodOfIncome {
    return Intl.message(
      'Period of income',
      name: 'periodOfIncome',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
  }

  /// `Currency`
  String get currency {
    return Intl.message('Currency', name: 'currency', desc: '', args: []);
  }

  /// `Select a currency`
  String get selectCurrency {
    return Intl.message(
      'Select a currency',
      name: 'selectCurrency',
      desc: '',
      args: [],
    );
  }

  /// `American Dollar`
  String get americanDollar {
    return Intl.message(
      'American Dollar',
      name: 'americanDollar',
      desc: '',
      args: [],
    );
  }

  /// `Euro`
  String get euro {
    return Intl.message('Euro', name: 'euro', desc: '', args: []);
  }

  /// `Brazilian Real`
  String get brazilianReal {
    return Intl.message(
      'Brazilian Real',
      name: 'brazilianReal',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }

  /// `Portuguese`
  String get portuguese {
    return Intl.message('Portuguese', name: 'portuguese', desc: '', args: []);
  }

  /// `English`
  String get english {
    return Intl.message('English', name: 'english', desc: '', args: []);
  }

  /// `Theme`
  String get theme {
    return Intl.message('Theme', name: 'theme', desc: '', args: []);
  }

  /// `System`
  String get system {
    return Intl.message('System', name: 'system', desc: '', args: []);
  }

  /// `Light`
  String get light {
    return Intl.message('Light', name: 'light', desc: '', args: []);
  }

  /// `Dark`
  String get dark {
    return Intl.message('Dark', name: 'dark', desc: '', args: []);
  }

  /// `Success`
  String get success {
    return Intl.message('Success', name: 'success', desc: '', args: []);
  }

  /// `Successfull updated`
  String get changesWasUpdated {
    return Intl.message(
      'Successfull updated',
      name: 'changesWasUpdated',
      desc: '',
      args: [],
    );
  }

  /// `Update Occurrences`
  String get occurrences {
    return Intl.message(
      'Update Occurrences',
      name: 'occurrences',
      desc: '',
      args: [],
    );
  }

  /// `Just it`
  String get updateJustIt {
    return Intl.message('Just it', name: 'updateJustIt', desc: '', args: []);
  }

  /// `All occurrences`
  String get updateAppOccurrences {
    return Intl.message(
      'All occurrences',
      name: 'updateAppOccurrences',
      desc: '',
      args: [],
    );
  }

  /// `Você precisa escolher uma opção`
  String get youMustPickAnOption {
    return Intl.message(
      'Você precisa escolher uma opção',
      name: 'youMustPickAnOption',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message('Profile', name: 'profile', desc: '', args: []);
  }

  /// `Image link`
  String get imageLink {
    return Intl.message('Image link', name: 'imageLink', desc: '', args: []);
  }

  /// `Add image a image link`
  String get addLinkImage {
    return Intl.message(
      'Add image a image link',
      name: 'addLinkImage',
      desc: '',
      args: [],
    );
  }

  /// `Sign in with Apple`
  String get appleSignIn {
    return Intl.message(
      'Sign in with Apple',
      name: 'appleSignIn',
      desc: '',
      args: [],
    );
  }

  /// `Sign in with Google`
  String get googleSignIn {
    return Intl.message(
      'Sign in with Google',
      name: 'googleSignIn',
      desc: '',
      args: [],
    );
  }

  /// `Sign Out`
  String get signOut {
    return Intl.message('Sign Out', name: 'signOut', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'pt'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
