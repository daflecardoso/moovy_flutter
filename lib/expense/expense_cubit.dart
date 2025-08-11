import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'expense_state.dart';

class ExpenseCubit extends Cubit<ExpenseState> {
  ExpenseCubit() : super(ExpenseInitial());
}
