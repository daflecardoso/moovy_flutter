
class CurrencyOption {
  final String code;
  final String title;
  final String symbol;

  CurrencyOption(this.code, this.title, this.symbol);

  CurrencyOption copyWith({ required String title }) {
    return CurrencyOption(code, title, symbol);
  }
}