import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moovy/database/dao/movement_dao.dart';
import 'package:moovy/database/domain/movement.dart';
import 'package:moovy/events/movement_changed.dart';
import 'package:moovy/extensions/string_extensions.dart';
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

  Future<void> createMovement({required Map<Object, dynamic> data}) async {
    try {
      String description = data['description'];
      ShadDateTimeRange period = data['period'];
      String amount = data['amount'];
      String? incomeDay = data['incomeDay'];
      String? dueDay = data['dueDay'];

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
      if (id == null) {
        await movementDao.insertMovement(movement);
      } else {
        await movementDao.updateMovement(movement);
      }
      eventBus.fire(MovementChanged(movement));
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
    }
  }

  Future<void> delete() async {
    if (id case final id?) {
      await movementDao.deleteById(id);
    }
  }
}
