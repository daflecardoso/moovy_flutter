part of 'main_cubit.dart';

@immutable
sealed class MainState {}

final class MainInitial extends MainState {}

final class MainLoaded extends MainState {
  final ThemeMode themeMode;
  final List<Locale> supportedLocales;
  final List<LocalizationsDelegate<dynamic>> localizationDelegate;
  final Locale locale;

  MainLoaded({
    required this.supportedLocales,
    required this.locale,
    required this.localizationDelegate,
    required this.themeMode,
  });
}
