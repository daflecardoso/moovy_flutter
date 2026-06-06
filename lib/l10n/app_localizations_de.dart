// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get movements => 'Bewegungen';

  @override
  String get emptyMovements => 'Keine Bewegungen';

  @override
  String youDonTHaveMovements(Object month) {
    return 'Du hast keine Bewegungen für $month';
  }

  @override
  String get totalIncome => 'Gesamteinnahmen';

  @override
  String get totalExpense => 'Gesamtausgaben';

  @override
  String get total => 'Gesamt';

  @override
  String get incomeExpense => 'Einnahmen und Ausgaben';

  @override
  String get expense => 'Ausgabe';

  @override
  String get income => 'Einnahme';

  @override
  String get expenseDescription => 'Ausgabenbeschreibung';

  @override
  String get expenseDescriptionHint => 'Bsp: Kreditkartenrechnung';

  @override
  String get descriptionCannotBeEmpty =>
      'Die Beschreibung darf nicht leer sein.';

  @override
  String get amount => 'Betrag';

  @override
  String get amountHint => 'Bsp: €150,00';

  @override
  String get amountDescription => 'Betrag pro Monat';

  @override
  String get amountEmptyValue => 'Bitte geben Sie einen Wert ein.';

  @override
  String get dueDayExpense => 'Fälligkeitstag der Ausgabe';

  @override
  String get dueDayIsRequired => 'Fälligkeitstag ist erforderlich';

  @override
  String get dueDayExpenseHint => 'Bsp: 10';

  @override
  String get periodOfExpense => 'Ausgabenzeitraum';

  @override
  String get periodOfExpenseDescription =>
      'Wenn kein Enddatum vorhanden ist, wähle das Startdatum.';

  @override
  String get startDateOrRangeIsRequired =>
      'Startdatum oder Zeitraum ist erforderlich.';

  @override
  String get save => 'Speichern';

  @override
  String get delete => 'Löschen';

  @override
  String get incomeDescription => 'Einnahmenbeschreibung';

  @override
  String get incomeHint => 'Bsp: Gehalt';

  @override
  String get incomeDay => 'Einnahmentag';

  @override
  String get incomeDayIsRequired => 'Einnahmentag ist erforderlich';

  @override
  String get periodOfIncome => 'Einnahmenzeitraum';

  @override
  String get settings => 'Einstellungen';

  @override
  String get currency => 'Währung';

  @override
  String get selectCurrency => 'Währung auswählen';

  @override
  String get americanDollar => 'US-Dollar';

  @override
  String get euro => 'Euro';

  @override
  String get brazilianReal => 'Brasilianischer Real';

  @override
  String get danishKrone => 'Dänische Krone';

  @override
  String get chineseYuan => 'Chinesischer Yuan';

  @override
  String get japaneseYen => 'Japanischer Yen';

  @override
  String get koreanWon => 'Koreanischer Won';

  @override
  String get language => 'Sprache';

  @override
  String get portuguese => 'Portugiesisch';

  @override
  String get english => 'Englisch';

  @override
  String get spanish => 'Spanisch';

  @override
  String get danish => 'Dänisch';

  @override
  String get german => 'Deutsch';

  @override
  String get chinese => 'Chinesisch';

  @override
  String get japanese => 'Japanisch';

  @override
  String get korean => 'Koreanisch';

  @override
  String get theme => 'Thema';

  @override
  String get system => 'System';

  @override
  String get light => 'Hell';

  @override
  String get dark => 'Dunkel';

  @override
  String get success => 'Erfolg';

  @override
  String get changesWasUpdated => 'Erfolgreich aktualisiert';

  @override
  String get occurrences => 'Vorkommen aktualisieren';

  @override
  String get updateJustIt => 'Nur dieses';

  @override
  String get updateAppOccurrences => 'Alle Vorkommen';

  @override
  String get youMustPickAnOption => 'Du musst eine Option wählen';

  @override
  String get profile => 'Profil';

  @override
  String get imageLink => 'Bildlink';

  @override
  String get addLinkImage => 'Füge einen Bildlink hinzu';

  @override
  String get appleSignIn => 'Mit Apple anmelden';

  @override
  String get googleSignIn => 'Mit Google anmelden';

  @override
  String get signOut => 'Abmelden';

  @override
  String get refresh => 'Aktualisieren';

  @override
  String get somethingWrong => 'Etwas ist schiefgelaufen';

  @override
  String get tryAgain => 'Erneut versuchen';

  @override
  String get thisMonth => 'Diesen Monat';

  @override
  String get future => 'Zukunft';

  @override
  String get rent => 'Miete';

  @override
  String get salary => 'Gehalt';

  @override
  String get netflix => 'Netflix';

  @override
  String get spotify => 'Spotify';

  @override
  String get internet => 'Internet';

  @override
  String get supermarket => 'Supermarkt';

  @override
  String get gym => 'Fitnessstudio';

  @override
  String get screenshotMovementsTitle => 'Jeden Cent\nim Blick behalten';

  @override
  String get screenshotExpenseTitle => 'Ausgaben in\nSekunden erfassen';

  @override
  String get screenshotProfileTitle => 'Volle Kontrolle\nüber dein Budget';
}
