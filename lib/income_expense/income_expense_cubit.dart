import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moovy/core/database.dart';
import 'package:moovy/storage/domain/movement.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

part 'income_expense_state.dart';

enum IncomeExpenseTabs {
  expense,
  income,
}

class IncomeExpenseCubit extends Cubit<IncomeExpenseState> {
  IncomeExpenseCubit() : super(IncomeExpenseInitial());

  IncomeExpenseTabs tab = IncomeExpenseTabs.expense;

  void setTab(IncomeExpenseTabs tab) {
    this.tab = tab;
  }

  Future<void> createMovement({ required Map<Object, dynamic> data }) async {
    try {
      final database = await $FloorAppDatabase.databaseBuilder('moovy.db')
          .build();
      print("✅ ${database.database.database.path}");
      String description = data['description'];
      ShadDateTimeRange period = data['period'];
      String amount = data['amount'];
      DateTime? incomeDate = data['incomeDate'];
      DateTime? dueDate = data['dueDate'];

      final movement = Movement(
          id: null,
          description: description,
          amount: int.parse(amount.replaceAll(RegExp(r'[^0-9]'), '')),
          incomeDate: incomeDate,
          dueDate: dueDate,
          startDate: period.start,
          endDate: period.end,
          type: MovementType.fromName(tab.name)
      );
      await database.movementDao.insertMovement(movement);
      print("✅ ${movement.toJson()}");
    } catch(e, s) {
      debugPrintStack(stackTrace: s);
    }
  }
}
