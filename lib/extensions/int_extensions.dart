import 'package:moovy/main.dart';

extension IntExtensions on int {
  String currency() {
    return globalCurrencyFormat.format(this / 100);
  }
}
