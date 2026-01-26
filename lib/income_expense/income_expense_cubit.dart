import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moovy/database/dao/movement_dao.dart';
import 'package:moovy/database/domain/movement/movement.dart';
import 'package:moovy/events/movement_changed.dart';
import 'package:moovy/extensions/date_time_extensions.dart';
import 'package:moovy/extensions/string_extensions.dart';
import 'package:moovy/income_expense/occurrence.dart';
import 'package:moovy/main.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

part 'income_expense_state.dart';

enum IncomeExpenseTabs { expense, income }

class IncomeExpenseCubit extends Cubit<IncomeExpenseState> {
  final MovementDao movementDao;
  final int? id;
  IncomeExpenseTabs tab;
  IncomeExpenseCubit(this.movementDao, this.id, this.tab) : super(IncomeExpenseInitial()) {
    getById();
  }

  void setTab(IncomeExpenseTabs tab) {
    this.tab = tab;
  }

  Future<void> getById() async {
    if (id case final id?) {
      try {
        final movement = await movementDao.findById(id);
        if (movement != null) {
          emit(IncomeExpenseForm(movement, movement));
        } else {
          emit(IncomeExpenseForm(null, null));
        }
      } catch (e, s) {
        debugPrintStack(stackTrace: s);
      }
    } else {
      emit(IncomeExpenseForm(null, null));
    }
  }

  Future<void> createMovement({required Map<Object, dynamic> data, required DateTime monthTab}) async {
    try {
      String description = data['description'];
      ShadDateTimeRange period = data['period'];
      String amount = data['amount'];
      String? incomeDay = data['incomeDay'];
      String? dueDay = data['dueDay'];

      if (id case final id?) {
        Occurrence occurrence = data['occurrence'];
        final movementDb = await movementDao.findById(id);
        if (movementDb == null) {
          throw Exception('Movement not found');
        }
        final movement = movementDb.copyWith(
          id: id,
          description: description,
          amount: amount.digits().toInt(),
          incomeDay: incomeDay?.toInt(),
          dueDay: dueDay?.toInt(),
          startDate: period.start!,
          endDate: period.end,
          type: MovementType.fromName(tab.name),
          updatedAt: DateTime.now(),
        );
        switch(occurrence) {
          case Occurrence.it:
            try {
              //equal DB previous months
              final previousMonth = monthTab.copyWith(day: movement.startDate.day).addMonths(-1);
              final newMovement = movementDb.copyWith(id: null, endDate: previousMonth);
              await movementDao.insertMovement(newMovement);

              final thisMonth = monthTab.copyWith(day: movement.startDate.day);
              final toUpdateMovement = movement.copyWith(id: id, startDate: thisMonth, endDate: thisMonth);
              await movementDao.updateMovement(toUpdateMovement);

              //equal DB to next months
              final nextMonth = monthTab.copyWith(day: movement.startDate.day).addMonths(1);
              final recurrence = movementDb.copyWith(id: null, startDate: nextMonth);
              await movementDao.insertMovement(recurrence);
            } catch(e, s) {
              debugPrintStack(stackTrace: s);
            }
          case Occurrence.all:
            await movementDao.updateMovement(movement);
        }

        eventBus.fire(MovementChanged(movement));
      } else {
        final movement = Movement(
          id: id,
          description: description,
          amount: amount.digits().toInt(),
          incomeDay: incomeDay?.toInt(),
          dueDay: dueDay?.toInt(),
          startDate: period.start!,
          endDate: period.end,
          type: MovementType.fromName(tab.name),
          paid: false,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
        await movementDao.insertMovement(movement);
        eventBus.fire(MovementChanged(movement));
      }
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
    }
  }

  Future<void> delete() async {
    if (id case final id?) {
      await movementDao.deleteById(id);
      eventBus.fire(MovementChanged(null));
    }
  }
}
