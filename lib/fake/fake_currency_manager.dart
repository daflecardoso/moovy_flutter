import 'package:moovy/core/currency/currency_manager.dart';
import 'package:moovy/core/currency/currency_option.dart';
import 'package:moovy/core/shared_preferences/shared_preferences_manager.dart';
import 'package:moovy/l10n/app_localizations.dart';

class FakeCurrencyManager implements CurrencyManager {
  @override
  late SharedPreferencesManager sharedPreferencesManager;

  @override
  Future<CurrencyOption> current() async {
    return getCurrencies(null).first;
  }

  @override
  List<CurrencyOption> getCurrencies(AppLocalizations? appLocalization) {
    return [CurrencyOption('\$S', 'dollar', '\$S')];
  }

  @override
  Future<void> save(String currency) {
    // TODO: implement save
    throw UnimplementedError();
  }
}
