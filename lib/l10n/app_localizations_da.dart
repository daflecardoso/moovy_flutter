// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Danish (`da`).
class AppLocalizationsDa extends AppLocalizations {
  AppLocalizationsDa([String locale = 'da']) : super(locale);

  @override
  String get movements => 'Bevægelser';

  @override
  String get emptyMovements => 'Ingen Bevægelser';

  @override
  String youDonTHaveMovements(Object month) {
    return 'Du har ingen bevægelser i $month';
  }

  @override
  String get totalIncome => 'Samlet Indkomst';

  @override
  String get totalExpense => 'Samlet Udgift';

  @override
  String get total => 'Total';

  @override
  String get incomeExpense => 'Indkomst og Udgifter';

  @override
  String get expense => 'Udgift';

  @override
  String get income => 'Indkomst';

  @override
  String get expenseDescription => 'Udgiftsbeskrivelse';

  @override
  String get expenseDescriptionHint => 'Eks: Kreditkortfaktura';

  @override
  String get descriptionCannotBeEmpty => 'Beskrivelsen må ikke være tom.';

  @override
  String get amount => 'Beløb';

  @override
  String get amountHint => 'Eks: kr 150,00';

  @override
  String get amountDescription => 'Beløb pr. måned';

  @override
  String get amountEmptyValue => 'Indtast venligst en værdi.';

  @override
  String get dueDayExpense => 'Forfaldsdato for udgift';

  @override
  String get dueDayIsRequired => 'Forfaldsdato er påkrævet';

  @override
  String get dueDayExpenseHint => 'Eks: 10';

  @override
  String get periodOfExpense => 'Udgiftsperiode';

  @override
  String get periodOfExpenseDescription =>
      'Hvis der ikke er en slutdato, vælg startdatoen.';

  @override
  String get startDateOrRangeIsRequired =>
      'Startdato eller periode er påkrævet.';

  @override
  String get save => 'Gem';

  @override
  String get delete => 'Slet';

  @override
  String get incomeDescription => 'Indkomstbeskrivelse';

  @override
  String get incomeHint => 'Eks: Løn';

  @override
  String get incomeDay => 'Indkomstdag';

  @override
  String get incomeDayIsRequired => 'Indkomstdag er påkrævet';

  @override
  String get periodOfIncome => 'Indkomstperiode';

  @override
  String get settings => 'Indstillinger';

  @override
  String get currency => 'Valuta';

  @override
  String get selectCurrency => 'Vælg en valuta';

  @override
  String get americanDollar => 'Amerikansk Dollar';

  @override
  String get euro => 'Euro';

  @override
  String get brazilianReal => 'Brasiliansk Real';

  @override
  String get danishKrone => 'Dansk Krone';

  @override
  String get chineseYuan => 'Kinesisk Yuan';

  @override
  String get japaneseYen => 'Japansk Yen';

  @override
  String get koreanWon => 'Koreansk Won';

  @override
  String get language => 'Sprog';

  @override
  String get portuguese => 'Portugisisk';

  @override
  String get english => 'Engelsk';

  @override
  String get spanish => 'Spansk';

  @override
  String get danish => 'Dansk';

  @override
  String get german => 'Tysk';

  @override
  String get chinese => 'Kinesisk';

  @override
  String get japanese => 'Japansk';

  @override
  String get korean => 'Koreansk';

  @override
  String get theme => 'Tema';

  @override
  String get system => 'System';

  @override
  String get light => 'Lys';

  @override
  String get dark => 'Mørk';

  @override
  String get success => 'Succes';

  @override
  String get changesWasUpdated => 'Opdateret med succes';

  @override
  String get occurrences => 'Opdater Forekomster';

  @override
  String get updateJustIt => 'Kun denne';

  @override
  String get updateAppOccurrences => 'Alle forekomster';

  @override
  String get youMustPickAnOption => 'Du skal vælge en mulighed';

  @override
  String get profile => 'Profil';

  @override
  String get imageLink => 'Billedlink';

  @override
  String get addLinkImage => 'Tilføj et billedlink';

  @override
  String get appleSignIn => 'Log ind med Apple';

  @override
  String get googleSignIn => 'Log ind med Google';

  @override
  String get signOut => 'Log ud';

  @override
  String get refresh => 'Opdater';

  @override
  String get somethingWrong => 'Noget gik galt';

  @override
  String get tryAgain => 'Prøv igen';

  @override
  String get thisMonth => 'Denne måned';

  @override
  String get future => 'Fremtid';

  @override
  String get rent => 'Husleje';

  @override
  String get salary => 'Løn';

  @override
  String get netflix => 'Netflix';

  @override
  String get spotify => 'Spotify';

  @override
  String get internet => 'Internet';

  @override
  String get supermarket => 'Supermarked';

  @override
  String get gym => 'Fitnesscenter';

  @override
  String get screenshotMovementsTitle => 'Følg med i\nhver øre hver dag';

  @override
  String get screenshotExpenseTitle => 'Tilføj udgifter\npå sekunder';

  @override
  String get screenshotProfileTitle => 'Fuld kontrol\nover dit budget';
}
