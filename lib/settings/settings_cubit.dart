import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moovy/core/currency/currency_manager.dart';
import 'package:moovy/core/currency/currency_option.dart';
import 'package:moovy/core/language/locale_manager.dart';
import 'package:moovy/core/language/moovy_locale.dart';
import 'package:moovy/core/shared_preferences/shared_preferences_manager.dart';
import 'package:moovy/core/theme/theme_manager.dart';
import 'package:moovy/core/theme/theme_option.dart';
import 'package:moovy/database/domain/settings/settings_request.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SharedPreferencesManager sharedPreferencesManager;
  LocaleManager localeManager;
  ThemeManager themeManager;
  CurrencyManager currencyManager;

  SettingsCubit(this.sharedPreferencesManager, this.localeManager, this.themeManager, this.currencyManager)
    : super(SettingsInitial());

  Future<void> setup() async {
    emit(
      SettingsForm(
        languages: localeManager.supportedLocales,
        language: await localeManager.current(),
        themes: themeManager.themes,
        theme: await themeManager.current(),
        currencies: currencyManager.currencies,
        currency: await currencyManager.current(),
      ),
    );
  }

  Future<void> save(Map<Object, dynamic> object) async {
    final settings = SettingsRequest.fromJson({
      'currency': object['currency'],
      'language': object['language'],
      'theme': object['theme']
    });

    if (settings.currency case final currency?) {
      await currencyManager.save(currency);
    }

    if (settings.language case final language?) {
      await localeManager.save(language);
    }

    if (settings.theme case final theme?) {
      await themeManager.save(theme);
    }
  }
}