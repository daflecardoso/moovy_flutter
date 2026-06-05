import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:moovy/core/currency/currency_manager.dart';
import 'package:moovy/core/language/locale_manager.dart';
import 'package:moovy/core/theme/theme_manager.dart';
import 'package:moovy/database/dao/movement_dao.dart';
import 'package:moovy/database/database.dart';
import 'package:moovy/fake/fake_app_database.dart';
import 'package:moovy/fake/fake_currency_manager.dart';
import 'package:moovy/fake/fake_locale_manager.dart';
import 'package:moovy/fake/fake_movement_dao.dart';
import 'package:moovy/fake/fake_movement_repository.dart';
import 'package:moovy/fake/fake_shared_preferences.dart';
import 'package:moovy/fake/fake_theme_manager.dart';
import 'package:moovy/repository/movement_repository.dart';

import 'core/shared_preferences/shared_preferences_manager.dart';
import 'di.config.dart';

final getIt = GetIt.instance;

@InjectableInit(initializerName: 'init', preferRelativeImports: true, asExtension: true)
void configureDependencies({bool fake = false}) {
  if (!fake) {
    getIt.init();
    return;
  }
  getIt.registerFactory<SharedPreferencesManager>(() => FakeSharedPreferences());
  getIt.registerFactory<AppDatabase>(() => FakeAppDataBase());
  getIt.registerFactory<LocaleManager>(() => FakeLocaleManager());
  getIt.registerFactory<ThemeManager>(() => FakeThemeManager());
  getIt.registerSingleton<CurrencyManager>(FakeCurrencyManager());
  getIt.registerFactory<MovementDao>(() => FakeMovementDao());
  getIt.registerFactory<MovementRepository>(() => FakeMovementRepository());
}
