import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moovy/design_system/moovy_gradient.dart';
import 'package:moovy/l10n/app_localizations.dart';
import 'package:moovy/navigation_service.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

String? cjkFontFamily(String lang) => switch (lang) {
  'ja' => 'NotoSansJP',
  'ko' => 'NotoSansKR',
  'zh' => 'NotoSansSC',
  _ => null,
};

Future<void> loadCjkFont(String lang) async {
  final family = cjkFontFamily(lang);
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


class Mockup extends StatelessWidget {
  final Locale locale;
  final Function(AppLocalizations) titleOf;
  final Widget screen;

  const Mockup({super.key, required this.locale, required this.titleOf, required this.screen});

  @override
  Widget build(BuildContext context) {
    // Geist (shadcn_ui default) is loaded by loadAppFonts() via the package manifest
    const geistFamily = 'packages/shadcn_ui/Geist';

    // Shadcn ShadSlateColorScheme.dark() colors
    // background: #020817  secondary/muted: #1e293b
    const bgGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Colors.black, Color(0xFF38B975)],
    );

    // Title: foreground (#f8fafc) → mutedForeground (#94a3b8) — shadcn dark palette
    const titleGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Colors.white, Color(0xFF38B975)],
    );

    final cjkFamily = cjkFontFamily(locale.languageCode);
    final titleFamily = cjkFamily ?? geistFamily;
    final textTheme = cjkFamily != null ? ShadTextTheme(family: cjkFamily) : ShadTextTheme();

    // Outer ShadApp — provides AppLocalizations for the title text
    return ShadApp(
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      themeMode: ThemeMode.dark,
      theme: ShadThemeData(
        brightness: Brightness.light,
        colorScheme: const ShadSlateColorScheme.light(),
        textTheme: textTheme,
      ),
      darkTheme: ShadThemeData(
        brightness: Brightness.dark,
        colorScheme: const ShadSlateColorScheme.dark(),
        textTheme: textTheme,
      ),
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
            theme: ShadThemeData(
              brightness: Brightness.light,
              colorScheme: const ShadSlateColorScheme.light(),
              textTheme: textTheme,
            ),
            darkTheme: ShadThemeData(
              brightness: Brightness.dark,
              colorScheme: const ShadSlateColorScheme.dark(
                background: Colors.transparent,
                accent: Colors.black
              ),
              textTheme: textTheme,
            ),
            debugShowCheckedModeBanner: false,
            navigatorKey: NavigationService.navigatorKey,
            home: Stack(
              children: [
                MoovyGradient(),
                screen
              ],
            ),
          );

          return Container(
            decoration: const BoxDecoration(gradient: bgGradient),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 48, 24, 16),
                  child: ShaderMask(
                    shaderCallback: (bounds) =>
                        titleGradient.createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
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
                    child: DeviceFrame(device: Devices.ios.iPhone16ProMax, screen: innerApp),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
