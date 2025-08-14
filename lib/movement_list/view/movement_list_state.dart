part of 'movement_list_cubit.dart';

@immutable
sealed class MovementListState {}

final class MovementListInitial extends MovementListState {}

final class MovementListSuccess extends MovementListState {
  final List<MonthTab> months;
  MovementListSuccess({
    required this.months,

  });
}
