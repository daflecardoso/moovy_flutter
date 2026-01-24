import 'dart:ui';

import 'package:intl/intl.dart';

extension IntExtensions on int {
  String currency({String? symbol, int? decimalDigits = 2}) {
    return NumberFormat.currency(symbol: symbol, decimalDigits: decimalDigits).format(this / 100);
  }
}
