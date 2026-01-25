// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get movements => 'Movements';

  @override
  String get emptyMovements => 'Empty Movements';

  @override
  String youDonTHaveMovements(Object month) {
    return 'You don\'t have any movements for $month';
  }

  @override
  String get totalIncome => 'Total Income';

  @override
  String get totalExpense => 'Total Expense';

  @override
  String get total => 'Total';

  @override
  String get incomeExpense => 'Income Expense';

  @override
  String get expense => 'Expense';

  @override
  String get income => 'Income';

  @override
  String get expenseDescription => 'Expense Description';

  @override
  String get expenseDescriptionHint => 'Ex: Invoice Credit Card';

  @override
  String get descriptionCannotBeEmpty => 'Description cannot be empty.';

  @override
  String get amount => 'Amount';

  @override
  String get amountHint => 'Ex: \$150.00';

  @override
  String get amountDescription => 'Amount per month';

  @override
  String get amountEmptyValue => 'Please type some value.';

  @override
  String get dueDayExpense => 'Due day of expense';

  @override
  String get dueDayIsRequired => 'Due day is required';

  @override
  String get dueDayExpenseHint => 'Ex: 10';

  @override
  String get periodOfExpense => 'Period of expense';

  @override
  String get periodOfExpenseDescription =>
      'If has not end date, pick the start date.';

  @override
  String get startDateOrRangeIsRequired =>
      'Start or range of dates is required.';

  @override
  String get save => 'Save';

  @override
  String get delete => 'Delete';

  @override
  String get incomeDescription => 'Income Description';

  @override
  String get incomeHint => 'Ex: Salary';

  @override
  String get incomeDay => 'Income Day';

  @override
  String get incomeDayIsRequired => 'Income Day is required';

  @override
  String get periodOfIncome => 'Period of income';

  @override
  String get settings => 'Settings';

  @override
  String get currency => 'Currency';

  @override
  String get selectCurrency => 'Select a currency';

  @override
  String get americanDollar => 'American Dollar';

  @override
  String get euro => 'Euro';

  @override
  String get brazilianReal => 'Brazilian Real';

  @override
  String get language => 'Language';

  @override
  String get portuguese => 'Portuguese';

  @override
  String get english => 'English';

  @override
  String get theme => 'Theme';

  @override
  String get system => 'System';

  @override
  String get light => 'Light';

  @override
  String get dark => 'Dark';
}
