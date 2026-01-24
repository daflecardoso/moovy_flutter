import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:injectable/injectable.dart';
import 'package:moovy/core/language/moovy_locale.dart';
import 'package:moovy/core/shared_preferences/shared_preferences_key.dart';
import 'package:moovy/core/shared_preferences/shared_preferences_manager.dart';

@injectable
class LocaleManager {
  SharedPreferencesManager sharedPreferencesManager;

  LocaleManager(this.sharedPreferencesManager);

  final localizationDelegate = [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  final _defaultLanguage = MoovyLocale('English', Locale('en', 'US'));

  late final supportedLocales = [
    _defaultLanguage,
    MoovyLocale('Portuguese', Locale('pt', 'BR')),
    MoovyLocale('Spanish', Locale('es', 'ES')),
    MoovyLocale('Germany', Locale('de', 'DE')),
  ];

  Future<MoovyLocale> current() async {
    final language = await sharedPreferencesManager.get(key: SharedPreferencesKey.language);
    if (language == null) {
      await save(_defaultLanguage.locale.toString());
      return await current();
    }
    return supportedLocales.firstWhere((ml) => ml.locale.toString() == language);
  }

  Future<void> save(String language) async {
    await sharedPreferencesManager.set(key: SharedPreferencesKey.language, value: language);
  }
}
