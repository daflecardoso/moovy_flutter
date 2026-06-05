import 'dart:io';

import 'package:app_deploy_screenshots/app_deploy_screenshots.dart';
import 'package:device_frame/device_frame.dart';
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

String? _cjkFontFamily(String lang) => switch (lang) {
  'ja' => 'NotoSansJP',
  'ko' => 'NotoSansKR',
  'zh' => 'NotoSansSC',
  _ => null,
};

// ---------------------------------------------------------------------------
// Mockup canvas device — 6.5" App Store dimensions (428×926 @ 3× = 1284×2778px)
// ---------------------------------------------------------------------------

const _mockupDevice = Device(
  name: 'mockup',
  size: Size(428, 926),
  displaySize: DisplaySize.sixFive,
  platform: DevicePlatform.ios,
  devicePixelRatio: 3.0,
  safeArea: EdgeInsets.only(top: 47 / 3, bottom: 34 / 3),
);

// Geist (shadcn_ui default) is loaded by loadAppFonts() via the package manifest
const _geistFamily = 'packages/shadcn_ui/Geist';

// Shadcn ShadSlateColorScheme.dark() colors
// background: #020817  secondary/muted: #1e293b
const _bgGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [Color(0xFF020817), Color(0xFF1e293b)],
);

// Title: foreground (#f8fafc) → mutedForeground (#94a3b8) — shadcn dark palette
const _titleGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFF8FAFC), Color(0xFF94A3B8)],
);

// ---------------------------------------------------------------------------
// Plain app wrapper (for App Store screenshots)
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
// Mockup wrapper — shadcn dark bg + green gradient title + DeviceFrame
// ---------------------------------------------------------------------------

Widget _mockup({
  required Locale locale,
  required String Function(AppLocalizations) titleOf,
  required Widget screen,
}) {
  final cjkFamily = _cjkFontFamily(locale.languageCode);
  final titleFamily = cjkFamily ?? _geistFamily;
  final textTheme = cjkFamily != null ? ShadTextTheme(family: cjkFamily) : ShadTextTheme();

  // Outer ShadApp — provides AppLocalizations for the title text
  return ShadApp(
    locale: locale,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    themeMode: ThemeMode.dark,
    theme: ShadThemeData(brightness: Brightness.light, colorScheme: const ShadSlateColorScheme.light(), textTheme: textTheme),
    darkTheme: ShadThemeData(brightness: Brightness.dark, colorScheme: const ShadSlateColorScheme.dark(), textTheme: textTheme),
    debugShowCheckedModeBanner: false,
    home: Builder(
      builder: (context) {
        final l10n = AppLocalizations.of(context)!;

        // Inner ShadApp — lives inside DeviceFrame, gets phone-sized MediaQuery
        final innerApp = ShadApp(
          locale: locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          themeMode: ThemeMode.dark,
          theme: ShadThemeData(brightness: Brightness.light, colorScheme: const ShadSlateColorScheme.light(), textTheme: textTheme),
          darkTheme: ShadThemeData(brightness: Brightness.dark, colorScheme: const ShadSlateColorScheme.dark(), textTheme: textTheme),
          debugShowCheckedModeBanner: false,
          home: screen,
        );

        return Container(
          decoration: const BoxDecoration(gradient: _bgGradient),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 48, 24, 16),
                child: ShaderMask(
                  shaderCallback: (bounds) => _titleGradient.createShader(
                    Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                  ),
                  blendMode: BlendMode.srcIn,
                  child: Text(
                    titleOf(l10n),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      height: 1.2,
                      fontFamily: titleFamily,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                  child: DeviceFrame(
                    device: Devices.ios.iPhone16ProMax,
                    screen: innerApp,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    ),
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

Future<void> _setup(String lang) async {
  Intl.defaultLocale = lang;
  await AppDeployScreenshots.loadAppFonts();
  await _loadCjkFont(lang);
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

    // ── App Store screenshots (plain, 6.5") ────────────────────────────────

    testWidgets('${lang}_01_movements', (tester) async {
      await _setup(lang);
      await tester.pumpWidget(_app(locale: locale, home: MovementListScreen()));
      await tester.pumpAndSettle();
      await AppDeployScreenshots.byDevices(
        tester,
        '01_movements',
        devices: [Device.iphone14Plus],
        fileNameBuilder: (device) => 'fastlane/screenshots/plain/${_deliverLocale(lang)}/01_movements.png',
      );
    });

    testWidgets('${lang}_02_add_expense', (tester) async {
      await _setup(lang);
      await tester.pumpWidget(_app(locale: locale, home: IncomeExpenseScreen(tabDate: DateTime.now().toIso8601String())));
      await tester.pumpAndSettle();
      await AppDeployScreenshots.byDevices(
        tester,
        '02_add_expense',
        devices: [Device.iphone14Plus],
        fileNameBuilder: (device) => 'fastlane/screenshots/plain/${_deliverLocale(lang)}/02_add_expense.png',
      );
    });

    testWidgets('${lang}_03_profile', (tester) async {
      await _setup(lang);
      await tester.pumpWidget(_app(locale: locale, home: const ProfileScreen()));
      await tester.pumpAndSettle();
      await AppDeployScreenshots.byDevices(
        tester,
        '03_profile',
        devices: [Device.iphone14Plus],
        fileNameBuilder: (device) => 'fastlane/screenshots/plain/${_deliverLocale(lang)}/03_profile.png',
      );
    });

    // ── Mockup screenshots (gradient bg + title + phone frame) ─────────────

    testWidgets('${lang}_mockup_01_movements', (tester) async {
      await _setup(lang);
      await tester.pumpWidget(_mockup(
        locale: locale,
        titleOf: (l10n) => l10n.screenshotMovementsTitle,
        screen: MovementListScreen(),
      ));
      await tester.pumpAndSettle();
      await AppDeployScreenshots.byDevices(
        tester,
        '01_movements_mockup',
        devices: [_mockupDevice],
        fileNameBuilder: (device) => 'fastlane/screenshots/mockup/${_deliverLocale(lang)}/01_movements.png',
      );
    });

    testWidgets('${lang}_mockup_02_add_expense', (tester) async {
      await _setup(lang);
      await tester.pumpWidget(_mockup(
        locale: locale,
        titleOf: (l10n) => l10n.screenshotExpenseTitle,
        screen: IncomeExpenseScreen(tabDate: DateTime.now().toIso8601String()),
      ));
      await tester.pumpAndSettle();
      await AppDeployScreenshots.byDevices(
        tester,
        '02_add_expense_mockup',
        devices: [_mockupDevice],
        fileNameBuilder: (device) => 'fastlane/screenshots/mockup/${_deliverLocale(lang)}/02_add_expense.png',
      );
    });

    testWidgets('${lang}_mockup_03_profile', (tester) async {
      await _setup(lang);
      await tester.pumpWidget(_mockup(
        locale: locale,
        titleOf: (l10n) => l10n.screenshotProfileTitle,
        screen: const ProfileScreen(),
      ));
      await tester.pumpAndSettle();
      await AppDeployScreenshots.byDevices(
        tester,
        '03_profile_mockup',
        devices: [_mockupDevice],
        fileNameBuilder: (device) => 'fastlane/screenshots/mockup/${_deliverLocale(lang)}/03_profile.png',
      );
    });
  }
}
