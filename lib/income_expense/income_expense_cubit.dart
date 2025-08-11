import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
}
