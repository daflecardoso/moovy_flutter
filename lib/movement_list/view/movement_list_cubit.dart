import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:moovy/database/dao/movement_dao.dart';
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
  final MovementDao movementDao;
  MovementListCubit(this.movementDao) : super(MovementListInitial()) {
    _init();
  }

  List<MonthTab> months = [];
  int tabIndex = 0;

  void _init() {
    final now = DateTime.now();
    tabIndex = now.month - 1;

    for (var i = 0; i < 12; i++) {
      months.add(MonthTab(DateTime(now.year, i + 1, 1)));
    }
    onTabChange(tabIndex);
    emit(MovementListSuccess(months: months, movements: [], totalExpense: 0, totalIncome: 0, total: 0));
  }

  Future<void> onTabChange(int index) async {
    try {
      tabIndex = index;
      final month = months[index];
      final currentMonthYear = month.date.format(DateTimeFormat.yyyyMM);
      final movements = await movementDao.findByMonthYear(currentMonthYear);
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
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
    }
  }

  Future<void> togglePaid(Movement movement) async {
    movement.paid = !movement.paid;
    await movementDao.updateMovement(movement);
    final state = this.state;
    if (state is MovementListSuccess) {
      final index = state.movements.indexOf(movement);
      state.movements[index] = movement;
      emit(state.copyWith(movements: state.movements));
    }
  }
}
