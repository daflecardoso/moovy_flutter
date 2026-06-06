import 'package:moovy/core/currency/currency_manager.dart';
import 'package:moovy/core/currency/currency_option.dart';
import 'package:moovy/core/shared_preferences/shared_preferences_manager.dart';
import 'package:moovy/l10n/app_localizations.dart';

class FakeCurrencyManager implements CurrencyManager {
  @override
  late SharedPreferencesManager sharedPreferencesManager;

  String currencyCode = 'usd';

  @override
  Future<CurrencyOption> current() async {
    return getCurrencies(null).firstWhere(
      (e) => e.code == currencyCode,
      orElse: () => getCurrencies(null).first,
    );
  }

  @override
  List<CurrencyOption> getCurrencies(AppLocalizations? appLocalization) {
    return [
      CurrencyOption('usd', 'American Dollar', '\$'),
      CurrencyOption('eur', 'Euro', '€'),
      CurrencyOption('brl', 'Brazilian Real', 'R\$'),
      CurrencyOption('dkk', 'Danish Krone', 'kr'),
      CurrencyOption('cny', 'Chinese Yuan', '¥'),
      CurrencyOption('jpy', 'Japanese Yen', '¥'),
      CurrencyOption('krw', 'Korean Won', '₩'),
    ];
  }

  @override
  Future<void> save(String currency) async {
    currencyCode = currency;
  }
}
