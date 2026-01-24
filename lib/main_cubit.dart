import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moovy/core/language/locale_manager.dart';
import 'package:moovy/core/shared_preferences/shared_preferences_manager.dart';
import 'package:moovy/core/theme/theme_manager.dart';
part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  final SharedPreferencesManager sharedPreferencesManager;
  final LocaleManager localeManager;
  final ThemeManager themeManager;

  MainCubit(this.sharedPreferencesManager, this.localeManager, this.themeManager) : super(MainInitial());

  Future<void> setup() async {
    final locale = await localeManager.current();
    final theme = await themeManager.current();
    emit(
      MainLoaded(
        supportedLocales: localeManager.supportedLocales.map((l) => l.locale).toList(),
        locale: locale.locale,
        localizationDelegate: localeManager.localizationDelegate,
        themeMode: theme.themeMode,
      ),
    );
  }
}
