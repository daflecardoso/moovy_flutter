part of 'movement_list_page_cubit.dart';

@immutable
sealed class MovementListPageState {}

final class MovementListPageInitial extends MovementListPageState {}

final class MovementPageSuccess extends MovementListPageState {
  final List<Movement> movements;
  final int totalExpense, totalIncome, total;

  MovementPageSuccess({
    required this.movements,
    required this.totalIncome,
    required this.totalExpense,
    required this.total,
});

  MovementPageSuccess copyWith({List<Movement>? movements}) => MovementPageSuccess(
    movements: movements ?? this.movements,
    totalExpense: totalExpense,
    totalIncome: totalIncome,
    total: total,
  );
}
