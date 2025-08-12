import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moovy/database/database.dart';
import 'package:moovy/database/domain/movement.dart';
import 'package:moovy/extensions/date_time_extensions.dart';

part 'expense_list_state.dart';

class MonthTab {
  final DateTime date;
  const MonthTab(this.date);

  String get title => date.format(DateTimeFormat.MMMMyyyy);
}

class ExpenseListCubit extends Cubit<ExpenseListState> {
  final DatabaseInstance _databaseInstance;
  ExpenseListCubit(DatabaseInstance databaseInstance)
    : _databaseInstance = databaseInstance,
      super(ExpenseListInitial()) {
    _init();
  }

  List<MonthTab> months = [];
  int initialIndex = 0;

  void _init() {
    final now = DateTime.now();
    initialIndex = now.month;

    for (var i = 0; i < 12; i++) {
      months.add(MonthTab(DateTime(now.year, i + 1, 1)));
    }
    onTabChange(initialIndex);
    emit(ExpenseListSuccess(months: months, movements: []));
  }

  Future<void> onTabChange(int index) async {
    try {
      final month = months[index];
      final db = await _databaseInstance.get();
      final currentMonthYear = month.date.format(DateTimeFormat.yyyyMM);
      final movements = await db.movementDao.findByMonthYear(currentMonthYear);
      emit(ExpenseListSuccess(months: months, movements: movements));
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
    }
  }
}
