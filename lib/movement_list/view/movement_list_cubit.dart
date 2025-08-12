import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:moovy/database/database.dart';
import 'package:moovy/database/domain/movement.dart';
import 'package:moovy/extensions/date_time_extensions.dart';
import 'package:moovy/extensions/list_int_extension.dart';

part 'movement_list_state.dart';

class MonthTab {
  final DateTime date;
  const MonthTab(this.date);

  String get title => date.format(DateTimeFormat.MMMMyyyy);
}

class MovementListCubit extends Cubit<MovementListState> {
  final DatabaseInstance _databaseInstance;
  MovementListCubit(DatabaseInstance databaseInstance)
    : _databaseInstance = databaseInstance,
      super(MovementListInitial()) {
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
    emit(MovementListSuccess(months: months, movements: [], totalExpense: 0, totalIncome: 0, total: 0));
  }

  Future<void> onTabChange(int index) async {
    try {
      final month = months[index];
      final db = await _databaseInstance.get();
      final currentMonthYear = month.date.format(DateTimeFormat.yyyyMM);
      final movements = await db.movementDao.findByMonthYear(currentMonthYear);
      final totalExpense = movements
          .where((e) => e.type == MovementType.expense)
          .map((e) => e.amount)
          .toList()
          .sum;
      final totalIncome = movements
          .where((e) => e.type == MovementType.income)
          .map((e) => e.amount)
          .toList()
          .sum;
      emit(
        MovementListSuccess(
          months: months,
          movements: movements,
          totalExpense: totalExpense,
          totalIncome: totalIncome,
          total: totalIncome - totalExpense,
        ),
      );
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
    }
  }
}
