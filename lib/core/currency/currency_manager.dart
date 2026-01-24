import 'package:injectable/injectable.dart';
import 'package:moovy/core/currency/currency_option.dart';
import 'package:moovy/core/shared_preferences/shared_preferences_key.dart';
import 'package:moovy/core/shared_preferences/shared_preferences_manager.dart';

@injectable
class CurrencyManager {
  SharedPreferencesManager sharedPreferencesManager;
  CurrencyManager(this.sharedPreferencesManager);

  final _defaultCurrency = CurrencyOption('usd', 'American Dollar');

  late final currencies = [
    _defaultCurrency,
    CurrencyOption('eur', 'Euro'),
    CurrencyOption('brl', 'Brazilian Real'),
  ];

  Future<CurrencyOption> current() async  {
    String? currency = await sharedPreferencesManager.get(key: SharedPreferencesKey.currency);
    if (currency == null) {
      await save(_defaultCurrency.code);
      return await current();
    }
    return currencies.firstWhere((e) => e.code == currency.toLowerCase());
  }

  Future<void> save(String currency) async {
    await sharedPreferencesManager.set(key: SharedPreferencesKey.currency, value: currency);
  }
}
