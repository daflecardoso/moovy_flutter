import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:moovy/core/shared_preferences/shared_preferences_key.dart';
import 'package:moovy/core/shared_preferences/shared_preferences_manager.dart';
import 'package:moovy/core/theme/theme_option.dart';
import 'package:moovy/l10n/app_localizations.dart';
import 'package:moovy/l10n/app_localizations_en.dart';

@injectable
class ThemeManager {
  SharedPreferencesManager sharedPreferencesManager;

  ThemeManager(this.sharedPreferencesManager);

  Future<ThemeOption> current() async {
    final theme = await sharedPreferencesManager.get(key: SharedPreferencesKey.theme);
    final themes = getThemes();
    if (theme == null) {
      await save(getThemes().first.themeMode.name);
      return await current();
    }
    return themes.firstWhere((e) => e.themeMode.name == theme);
  }

  Future<void> save(String theme) async {
    await sharedPreferencesManager.set(key: SharedPreferencesKey.theme, value: theme);
  }

  List<ThemeOption> getThemes({ AppLocalizations? appLocalizations }) {
    final appL = appLocalizations ?? AppLocalizationsEn();
    return [
      ThemeOption(appL.system, ThemeMode.system),
      ThemeOption(appL.light, ThemeMode.light),
      ThemeOption(appL.dark, ThemeMode.dark)
    ];
  }
}
