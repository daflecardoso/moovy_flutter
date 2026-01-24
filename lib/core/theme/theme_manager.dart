import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:moovy/core/shared_preferences/shared_preferences_key.dart';
import 'package:moovy/core/shared_preferences/shared_preferences_manager.dart';
import 'package:moovy/core/theme/theme_option.dart';

@injectable
class ThemeManager {
  SharedPreferencesManager sharedPreferencesManager;

  ThemeManager(this.sharedPreferencesManager);

  final _defaultTheme = ThemeOption('System', ThemeMode.system);

  late final themes = [
    _defaultTheme,
    ThemeOption('Light', ThemeMode.light),
    ThemeOption('Dark', ThemeMode.dark),
  ];

  Future<ThemeOption> current() async {
    final theme = await sharedPreferencesManager.get(key: SharedPreferencesKey.theme);
    if (theme == null) {
      await save(_defaultTheme.themeMode.name);
      return await current();
    }
    return themes.firstWhere((e) => e.themeMode.name == theme);
  }

  Future<void> save(String theme) async {
    await sharedPreferencesManager.set(key: SharedPreferencesKey.theme, value: theme);
  }
}
