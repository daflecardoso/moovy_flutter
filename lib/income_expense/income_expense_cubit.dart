import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moovy/database/database.dart';
import 'package:moovy/database/domain/movement.dart';
import 'package:moovy/extensions/string_extensions.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

part 'income_expense_state.dart';

enum IncomeExpenseTabs { expense, income }

class IncomeExpenseCubit extends Cubit<IncomeExpenseState> {
  final DatabaseInstance databaseInstance;
  final int? id;
  IncomeExpenseTabs tab;
  IncomeExpenseCubit(this.databaseInstance, this.id, this.tab) : super(IncomeExpenseInitial()) {
    getById();
  }

  void setTab(IncomeExpenseTabs tab) {
    this.tab = tab;
  }

  Future<void> getById() async {
    if (id case final id?) {
      try {
        final database = await databaseInstance.get();
        final movement = await database.movementDao.findById(id);
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
      final database = await databaseInstance.get();
      String description = data['description'];
      ShadDateTimeRange period = data['period'];
      String amount = data['amount'];
      DateTime? incomeDate = data['incomeDate'];
      DateTime? dueDate = data['dueDate'];

      final movement = Movement(
        id: id,
        description: description,
        amount: amount.digits().toInt(),
        incomeDate: incomeDate,
        dueDate: dueDate,
        startDate: period.start,
        endDate: period.end,
        type: MovementType.fromName(tab.name),
      );
      if (id == null) {
        await database.movementDao.insertMovement(movement);
      } else {
        await database.movementDao.updateMovement(movement);
      }
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
    }
  }

  Future<void> delete() async {
    if (id case final id?) {
      final database = await databaseInstance.get();
      await database.movementDao.deleteById(id);
    }
  }
}
