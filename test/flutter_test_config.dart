import 'dart:async';

import 'package:app_deploy_screenshots/app_deploy_screenshots.dart';
import 'package:intl/intl.dart';
import 'package:moovy/main.dart' as moovy;

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  moovy.globalCurrencyFormat = NumberFormat.currency(symbol: r'R$', decimalDigits: 2);
  await AppDeployScreenshots.initialize(loadFonts: false);
  return testMain();
}
