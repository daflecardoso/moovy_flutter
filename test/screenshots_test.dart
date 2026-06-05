import 'dart:io';

import 'package:app_deploy_screenshots/app_deploy_screenshots.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moovy/di.dart';
import 'package:moovy/income_expense/income_exepense_screen.dart';
import 'package:moovy/l10n/app_localizations.dart';
import 'package:moovy/movement_list/view/movement_list_screen.dart';
import 'package:moovy/profile/profile_screen.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

// ---------------------------------------------------------------------------
// Locale helpers
// ---------------------------------------------------------------------------

String _deliverLocale(String lang) => switch (lang) {
  'de' => 'de-DE',
  'en' => 'en-US',
  'es' => 'es-ES',
  'pt' => 'pt-BR',
  'zh' => 'zh-Hans',
  _ => lang, // da, ja, ko
};

// ---------------------------------------------------------------------------
// CJK font family per locale
// ---------------------------------------------------------------------------

String? _cjkFontFamily(String lang) {
  switch (lang) {
    case 'ja':
      return 'NotoSansJP';
    case 'ko':
      return 'NotoSansKR';
    case 'zh':
      return 'NotoSansSC';
    default:
      return null;
  }
}

// ---------------------------------------------------------------------------
// App wrapper
// ---------------------------------------------------------------------------

Widget _app({required Locale locale, required Widget home}) {
  final cjkFamily = _cjkFontFamily(locale.languageCode);
  return ShadApp(
    locale: locale,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    themeMode: ThemeMode.dark,
    theme: ShadThemeData(
      brightness: Brightness.light,
      colorScheme: const ShadSlateColorScheme.light(),
      textTheme: cjkFamily != null ? ShadTextTheme(family: cjkFamily) : ShadTextTheme(),
    ),
    darkTheme: ShadThemeData(
      brightness: Brightness.dark,
      colorScheme: const ShadSlateColorScheme.dark(),
      textTheme: cjkFamily != null ? ShadTextTheme(family: cjkFamily) : ShadTextTheme(),
    ),
    debugShowCheckedModeBanner: false,
    home: home,
  );
}

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

Future<void> _loadCjkFont(String lang) async {
  final family = _cjkFontFamily(lang);
  if (family == null) return;
  final assetPath = switch (lang) {
    'ja' => 'assets/fonts/NotoSansJP-Regular.ttf',
    'ko' => 'assets/fonts/NotoSansKR-Regular.ttf',
    'zh' => 'assets/fonts/NotoSansSC-Regular.ttf',
    _ => null,
  };
  if (assetPath == null) return;
  final loader = FontLoader(family)..addFont(rootBundle.load(assetPath));
  await loader.load();
}

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

void main() {
  configureDependencies(fake: true);

  setUpAll(() {
    HttpOverrides.global = null;
  });

  for (final locale in AppLocalizations.supportedLocales) {
    final lang = locale.languageCode;

    testWidgets('${lang}_01_movements', (tester) async {
      Intl.defaultLocale = lang;
      await AppDeployScreenshots.loadAppFonts();
      await _loadCjkFont(lang);
      await tester.pumpWidget(_app(locale: locale, home: MovementListScreen()));
      await tester.pumpAndSettle();
      await AppDeployScreenshots.byDevices(
        tester,
        '01_movements',
        devices: [Device.iphone14Plus],
        fileNameBuilder: (device) => 'fastlane/screenshots/${_deliverLocale(lang)}/01_movements.png',
      );
    });

    testWidgets('${lang}_02_add_expense', (tester) async {
      Intl.defaultLocale = lang;
      await AppDeployScreenshots.loadAppFonts();
      await _loadCjkFont(lang);
      await tester.pumpWidget(_app(locale: locale, home: IncomeExpenseScreen(tabDate: DateTime.now().toIso8601String())));
      await tester.pumpAndSettle();
      await AppDeployScreenshots.byDevices(
        tester,
        '02_add_expense',
        devices: [Device.iphone14Plus],
        fileNameBuilder: (device) => 'fastlane/screenshots/${_deliverLocale(lang)}/02_add_expense.png',
      );
    });

    testWidgets('${lang}_03_profile', (tester) async {
      Intl.defaultLocale = lang;
      await AppDeployScreenshots.loadAppFonts();
      await _loadCjkFont(lang);
      await tester.pumpWidget(_app(locale: locale, home: const ProfileScreen()));
      await tester.pumpAndSettle();
      await AppDeployScreenshots.byDevices(
        tester,
        '03_profile',
        devices: [Device.iphone14Plus],
        fileNameBuilder: (device) => 'fastlane/screenshots/${_deliverLocale(lang)}/03_profile.png',
      );
    });
  }
}
