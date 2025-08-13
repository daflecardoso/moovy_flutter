part of 'income_expense_cubit.dart';

@immutable
sealed class IncomeExpenseState {}

final class IncomeExpenseInitial extends IncomeExpenseState {

}

final class IncomeExpenseForm extends IncomeExpenseState {
  final Movement? expense, income;
  IncomeExpenseForm(this.expense, this.income);
}
