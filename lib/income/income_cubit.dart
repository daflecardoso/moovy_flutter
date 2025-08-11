import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'income_state.dart';

class IncomeCubit extends Cubit<IncomeState> {
  IncomeCubit() : super(IncomeInitial());
}
