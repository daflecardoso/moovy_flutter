part of 'settings_cubit.dart';

@immutable
sealed class SettingsState {}

final class SettingsInitial extends SettingsState {}

final class SettingsForm extends SettingsState {
  final List<MoovyLocale> languages;
  final MoovyLocale language;
  final List<ThemeOption> themes;
  final ThemeOption theme;
  final List<CurrencyOption> currencies;
  final CurrencyOption currency;

  SettingsForm({
    required this.languages,
    required this.language,
    required this.themes,
    required this.theme,
    required this.currencies,
    required this.currency,
  });
}
