import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moovy/database/dao/movement_dao.dart';
import 'package:moovy/database/domain/movement/movement.dart';
import 'package:moovy/extensions/date_time_extensions.dart';
import 'package:moovy/extensions/list_int_extension.dart';
import 'package:moovy/movement_list/view/movement_list_cubit.dart';

part 'movement_list_page_state.dart';

class MovementListPageCubit extends Cubit<MovementListPageState> {
  MovementDao movementDao;
  MovementListPageCubit(this.movementDao) : super(MovementListPageInitial());

  Future<void> getMovements(MonthTab month) async {
    try {
      final currentMonthYear = month.date.format(DateTimeFormat.yyyyMM);
      final movements = await movementDao.findByMonthYear(currentMonthYear);

      if (movements.isEmpty) {
        emit(MovementEmpty(title: 'Empty Movements', description: "You don't have any movements for ${month.title}"));
        return;
      }

      final totalExpense = movements.where((e) => e.type == MovementType.expense).map((e) => e.amount).toList().sum;
      final totalIncome = movements.where((e) => e.type == MovementType.income).map((e) => e.amount).toList().sum;
      emit(
        MovementPageSuccess(
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
    if (state is MovementPageSuccess) {
      final index = state.movements.indexOf(movement);
      state.movements[index] = movement;
      emit(state.copyWith(movements: state.movements));
    }
  }
}
