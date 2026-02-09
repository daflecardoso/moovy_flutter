import 'package:intl/intl.dart';
import 'package:moovy/extensions/string_extensions.dart';

enum DateTimeFormat {
  yyyyMM('yyyy-MM'),
  mmmmYyyy('MMMM yyyy'),
  dd('dd'),
  ddMM('dd MMM'),
  yyyymmddHHmmss('yyyymmddHHmmss')
  ;

  final String format;
  const DateTimeFormat(this.format);
}

extension DateTimeExtensions on DateTime {
  String format(DateTimeFormat format) {
    return DateFormat(format.format).format(this);
  }

  DateTime addMonths(int months) {
    return DateTime(year, month + months, day, hour, minute, second, millisecond, microsecond);
  }

  int yearMonth() {
    return "$year${month.toString().padLeft(2, '0')}".toInt();
  }
}
