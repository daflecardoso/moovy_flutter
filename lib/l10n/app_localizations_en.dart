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
}
