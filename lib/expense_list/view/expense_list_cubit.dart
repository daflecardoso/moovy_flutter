import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

part 'expense_list_state.dart';

class ExpenseListCubit extends Cubit<ExpenseListState> {
  ExpenseListCubit() : super(ExpenseListInitial()) {
    _init();
  }

  final months = [
    'Agosto',
    'Setembro',
    'Outubro',
    'Novembro',
    'Dezembro'
  ];

  void _init() {
    emit(ExpenseListSuccess());
  }
}
