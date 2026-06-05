
import 'package:flutter/material.dart';
import 'package:moovy/core/shared_preferences/shared_preferences_manager.dart';
import 'package:moovy/core/theme/theme_manager.dart';
import 'package:moovy/core/theme/theme_option.dart';
import 'package:moovy/l10n/app_localizations.dart';

class FakeThemeManager implements ThemeManager {
  @override
  late SharedPreferencesManager sharedPreferencesManager;

  @override
  Future<ThemeOption> current() async {
    return ThemeOption('Dark', ThemeMode.dark);
  }

  @override
  List<ThemeOption> getThemes({AppLocalizations? appLocalizations}) {
    return [
    ThemeOption('Dark', ThemeMode.dark)
    ];
  }

  @override
  Future<void> save(String theme) {
    // TODO: implement save
    throw UnimplementedError();
  }
}