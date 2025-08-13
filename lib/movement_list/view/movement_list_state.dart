part of 'movement_list_cubit.dart';

@immutable
sealed class MovementListState {}

final class MovementListInitial extends MovementListState {}

final class MovementListSuccess extends MovementListState {
  final List<MonthTab> months;
  final List<Movement> movements;
  final int totalExpense, totalIncome, total;
  MovementListSuccess({
    required this.months,
    required this.movements,
    required this.totalIncome,
    required this.totalExpense,
    required this.total,
  });

  MovementListSuccess copyWith({List<Movement>? movements}) => MovementListSuccess(
    months: months,
    movements: movements ?? this.movements,
    totalExpense: totalExpense,
    totalIncome: totalIncome,
    total: total,
  );
}
