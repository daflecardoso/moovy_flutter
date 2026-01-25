import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:moovy/core/currency/currency_manager.dart';
import 'package:moovy/core/language/locale_manager.dart';
import 'package:moovy/core/shared_preferences/shared_preferences_manager.dart';
import 'package:moovy/core/theme/theme_manager.dart';
import 'package:moovy/main.dart';
part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  final SharedPreferencesManager sharedPreferencesManager;
  final LocaleManager localeManager;
  final ThemeManager themeManager;
  final CurrencyManager currencyManager;

  MainCubit(this.sharedPreferencesManager, this.localeManager, this.themeManager, this.currencyManager) : super(MainInitial());

  Future<void> setup() async {
    final locale = await localeManager.current();
    final theme = await themeManager.current();
    final currency = await currencyManager.current();
    Intl.defaultLocale = locale.locale.toString();
    globalCurrencyFormat = NumberFormat.currency(symbol: currency.symbol);
    emit(
      MainLoaded(
        supportedLocales: localeManager.supportedLocales.map((l) => l).toList(),
        locale: locale.locale,
        localizationDelegate: localeManager.localizationDelegate,
        themeMode: theme.themeMode,
      ),
    );
  }
}
