import 'dart:io';

import 'package:app_deploy_screenshots/app_deploy_screenshots.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moovy/core/currency/currency_manager.dart';
import 'package:moovy/di.dart';
import 'package:moovy/fake/fake_currency_manager.dart';
import 'package:moovy/income_expense/income_exepense_screen.dart';
import 'package:moovy/l10n/app_localizations.dart';
import 'package:moovy/main.dart';
import 'package:moovy/movement_list/view/movement_list_screen.dart';
import 'package:moovy/profile/profile_screen.dart';
import 'package:moovy/settings/settings_screen.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import 'mockup.dart';

String _currencyForLang(String lang) => switch (lang) {
  'pt' => 'brl',
  'de' => 'eur',
  'da' => 'dkk',
  'zh' => 'cny',
  'ja' => 'jpy',
  'ko' => 'krw',
  _ => 'usd', // en, es
};

Future<void> _setup(String lang) async {
  Intl.defaultLocale = lang;

  (getIt<CurrencyManager>() as FakeCurrencyManager).currencyCode = _currencyForLang(lang);
  final fakeCurrency = (getIt<CurrencyManager>() as FakeCurrencyManager);
  final current = await fakeCurrency.current();
  globalCurrencyFormat = NumberFormat.currency(symbol: current.symbol);
  await AppDeployScreenshots.loadAppFonts();
  await loadCjkFont(lang);
}

String _deliverLocale(String lang) => switch (lang) {
  'de' => 'de-DE',
  'en' => 'en-US',
  'es' => 'es-ES',
  'pt' => 'pt-BR',
  'zh' => 'zh-Hans',
  _ => lang, // da, ja, ko
};

void main() {
  const mockupDevice = Device(
    name: 'mockup',
    size: Size(428, 926),
    displaySize: DisplaySize.sixFive,
    platform: DevicePlatform.ios,
    devicePixelRatio: 3.0,
    safeArea: EdgeInsets.only(top: 47 / 3, bottom: 34 / 3),
  );
  configureDependencies(fake: true);

  setUpAll(() {
    HttpOverrides.global = null;
  });

  for (final locale in AppLocalizations.supportedLocales) {
    final lang = locale.languageCode;


    testWidgets('${lang}_mockup_01_movements', (tester) async {
      await _setup(lang);
      await tester.pumpWidget(
        Mockup(locale: locale, titleOf: (l10n) => l10n.screenshotMovementsTitle, screen: MovementListScreen()),
      );
      await tester.pumpAndSettle();
      await AppDeployScreenshots.byDevices(
        tester,
        '01_movements_mockup',
        devices: [mockupDevice],
        fileNameBuilder: (device) => 'fastlane/screenshots/mockup/${_deliverLocale(lang)}/01_movements.png',
      );
    });

    testWidgets('${lang}_mockup_02_add_expense', (tester) async {
      await _setup(lang);
      await tester.pumpWidget(
        Mockup(
          locale: locale,
          titleOf: (l10n) => l10n.screenshotExpenseTitle,
          screen: IncomeExpenseScreen(tabDate: DateTime.now().toIso8601String()),
        ),
      );
      await tester.pumpAndSettle();
      await AppDeployScreenshots.byDevices(
        tester,
        '02_add_expense_mockup',
        devices: [mockupDevice],
        fileNameBuilder: (device) => 'fastlane/screenshots/mockup/${_deliverLocale(lang)}/02_add_expense.png',
      );
    });

    testWidgets('${lang}_mockup_03_profile', (tester) async {
      await _setup(lang);
      await tester.pumpWidget(
        Mockup(locale: locale, titleOf: (l10n) => l10n.screenshotProfileTitle, screen: const ProfileScreen()),
      );
      await tester.pumpAndSettle();
      await AppDeployScreenshots.byDevices(
        tester,
        '03_profile_mockup',
        devices: [mockupDevice],
        fileNameBuilder: (device) => 'fastlane/screenshots/mockup/${_deliverLocale(lang)}/03_profile.png',
      );
    });
  }
}
