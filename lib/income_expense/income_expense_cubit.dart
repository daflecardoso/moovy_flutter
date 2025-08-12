import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moovy/database/database.dart';
import 'package:moovy/database/domain/movement.dart';
import 'package:moovy/extensions/string_extensions.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

part 'income_expense_state.dart';

enum IncomeExpenseTabs { expense, income }

class IncomeExpenseCubit extends Cubit<IncomeExpenseState> {
  final DatabaseInstance _databaseInstance;
  IncomeExpenseCubit(DatabaseInstance databaseInstance)
    : _databaseInstance = databaseInstance,
      super(IncomeExpenseInitial());

  IncomeExpenseTabs tab = IncomeExpenseTabs.expense;

  void setTab(IncomeExpenseTabs tab) {
    this.tab = tab;
  }

  Future<void> createMovement({required Map<Object, dynamic> data}) async {
    try {
      final database = await _databaseInstance.get();
      String description = data['description'];
      ShadDateTimeRange period = data['period'];
      String amount = data['amount'];
      DateTime? incomeDate = data['incomeDate'];
      DateTime? dueDate = data['dueDate'];

      final movement = Movement(
        id: null,
        description: description,
        amount: amount.digits().toInt(),
        incomeDate: incomeDate,
        dueDate: dueDate,
        startDate: period.start,
        endDate: period.end,
        type: MovementType.fromName(tab.name),
      );
      await database.movementDao.insertMovement(movement);
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
    }
  }
}
