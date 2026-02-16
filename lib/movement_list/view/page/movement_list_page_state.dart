part of 'movement_list_page_cubit.dart';

@immutable
sealed class MovementListPageState {}

final class MovementListPageInitial extends MovementListPageState {}

final class MovementPageSuccess extends MovementListPageState {
  final List<Movement> movements;
  final int totalExpense, totalIncome, total;
  final Color totalColor;

  MovementPageSuccess({
    required this.movements,
    required this.totalIncome,
    required this.totalExpense,
    required this.total,
    required this.totalColor
  });

  MovementPageSuccess copyWith({List<Movement>? movements}) => MovementPageSuccess(
    movements: movements ?? this.movements,
    totalExpense: totalExpense,
    totalIncome: totalIncome,
    total: total,
    totalColor: totalColor,
  );
}

final class MovementEmpty extends MovementListPageState {
  final String month;
  MovementEmpty({required this.month});
}

final class MovementPageError extends MovementListPageState {
  final String error;

  MovementPageError({ required this.error });
}
