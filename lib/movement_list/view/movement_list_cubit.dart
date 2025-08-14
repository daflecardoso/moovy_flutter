import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:moovy/database/dao/movement_dao.dart';
import 'package:moovy/database/domain/movement.dart';
import 'package:moovy/extensions/date_time_extensions.dart';
import 'package:moovy/extensions/list_int_extension.dart';

part 'movement_list_state.dart';

class MonthTab {
  final DateTime date;
  const MonthTab(this.date);

  String get title => date.format(DateTimeFormat.MMMMyyyy);
}

class MovementListCubit extends Cubit<MovementListState> {
  final MovementDao movementDao;
  MovementListCubit(this.movementDao) : super(MovementListInitial()) {
    _init();
  }

  List<MonthTab> months = [];
  int tabIndex = 0;

  void _init() {
    final now = DateTime.now();
    tabIndex = now.month - 1;

    for (var i = 0; i < 12; i++) {
      months.add(MonthTab(DateTime(now.year, i + 1, 1)));
    }
    emit(MovementListSuccess(months: months));
  }
}
