import 'package:injectable/injectable.dart';
import 'package:moovy/core/currency/currency_option.dart';
import 'package:moovy/core/shared_preferences/shared_preferences_key.dart';
import 'package:moovy/core/shared_preferences/shared_preferences_manager.dart';
import 'package:moovy/l10n/app_localizations.dart';
import 'package:moovy/l10n/app_localizations_en.dart';

@singleton
class CurrencyManager {
  SharedPreferencesManager sharedPreferencesManager;

  CurrencyManager(this.sharedPreferencesManager);

  Future<CurrencyOption> current() async  {
    String? currency = await sharedPreferencesManager.get(key: SharedPreferencesKey.currency);
    if (currency == null) {
      await save(getCurrencies(null).first.code);
      return await current();
    }
    return getCurrencies(null).firstWhere((e) => e.code == currency.toLowerCase());
  }

  Future<void> save(String currency) async {
    await sharedPreferencesManager.set(key: SharedPreferencesKey.currency, value: currency);
  }

  List<CurrencyOption> getCurrencies(AppLocalizations? appLocalization) {
    final appL = appLocalization ?? AppLocalizationsEn();
    return [
      CurrencyOption('usd', appL.americanDollar, '\$'),
      CurrencyOption('eur', appL.euro, '€'),
      CurrencyOption('brl', appL.brazilianReal, 'R\$'),
    ];
  }
}
