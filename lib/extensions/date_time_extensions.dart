import 'dart:ui';

import 'package:intl/intl.dart';

enum DateTimeFormat {
  yyyyMM('yyyy-MM'),
  mmmmYyyy('MMMM yyyy'),
  dd('dd'),
  ddMM('dd MMM')
  ;

  final String format;
  const DateTimeFormat(this.format);
}

extension DateTimeExtensions on DateTime {
  String format(DateTimeFormat format) {
    return DateFormat(format.format).format(this);
  }
}
