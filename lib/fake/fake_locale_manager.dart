
import 'package:flutter/material.dart';
import 'package:moovy/core/language/locale_manager.dart';
import 'package:moovy/core/language/moovy_locale.dart';
import 'package:moovy/core/shared_preferences/shared_preferences_manager.dart';
import 'package:moovy/l10n/app_localizations.dart';

class FakeLocaleManager implements LocaleManager {
  @override
  late SharedPreferencesManager sharedPreferencesManager;

  @override
  Future<MoovyLocale> current() async {
    return parse(supportedLocales.first, null);
  }

  @override
  List<LocalizationsDelegate<dynamic>> get localizationDelegate => AppLocalizations.localizationsDelegates;

  @override
  MoovyLocale parse(Locale locale, AppLocalizations? appLocalizations) {
    return MoovyLocale(locale.languageCode, AppLocalizations.supportedLocales.first);
  }

  @override
  Future<void> save(String language) async {

  }

  @override
  List<Locale> get supportedLocales => AppLocalizations.supportedLocales;
}