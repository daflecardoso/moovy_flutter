part of 'expense_list_cubit.dart';

@immutable
sealed class ExpenseListState {}

final class ExpenseListInitial extends ExpenseListState {}

final class ExpenseListSuccess extends ExpenseListState {}
