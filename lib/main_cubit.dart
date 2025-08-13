import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainInitial(ThemeMode.dark));

  void toggleTheme() {
    final state = this.state;
    if (state is MainInitial) {
      emit(MainInitial(state.themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark));
    }
  }
}

