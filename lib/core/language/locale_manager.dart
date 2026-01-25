
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:moovy/core/language/moovy_locale.dart';
import 'package:moovy/core/shared_preferences/shared_preferences_key.dart';
import 'package:moovy/core/shared_preferences/shared_preferences_manager.dart';
import 'package:moovy/l10n/app_localizations.dart';
import 'package:moovy/l10n/app_localizations_en.dart';

@injectable
class LocaleManager {
  SharedPreferencesManager sharedPreferencesManager;

  LocaleManager(this.sharedPreferencesManager);

  final localizationDelegate = AppLocalizations.localizationsDelegates;

  late final supportedLocales = AppLocalizations.supportedLocales;

  Future<MoovyLocale> current() async {
    final language = await sharedPreferencesManager.get(key: SharedPreferencesKey.language);
    if (language == null) {
      await save(supportedLocales.first.toString());
      return await current();
    }
    try {
      return parse(supportedLocales.firstWhere((l) => l.toString() == language), null);
    } catch (e) {
      return parse(supportedLocales.first, null);
    }
  }

  MoovyLocale parse(Locale locale, AppLocalizations? appLocalizations) {
    final appL = appLocalizations ?? AppLocalizationsEn();
    return switch (locale.toString()) {
      'en' => MoovyLocale(appL.english, locale),
      'pt' => MoovyLocale(appL.portuguese, locale),
      String() => MoovyLocale(locale.languageCode, locale),
    };
  }

  Future<void> save(String language) async {
    await sharedPreferencesManager.set(key: SharedPreferencesKey.language, value: language);
  }
}
