// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get movements => 'Movimentações';

  @override
  String get emptyMovements => 'Sem Movimentações';

  @override
  String youDonTHaveMovements(Object month) {
    return 'Você não tem nenhuma movimentação em $month';
  }

  @override
  String get totalIncome => 'Total Entradas';

  @override
  String get totalExpense => 'Total Saída';

  @override
  String get total => 'Total';
}
