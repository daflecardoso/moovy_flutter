// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import 'core/currency/currency_manager.dart' as _i948;
import 'core/language/locale_manager.dart' as _i963;
import 'core/shared_preferences/shared_preferences_manager.dart' as _i666;
import 'core/theme/theme_manager.dart' as _i1044;
import 'database/dao/movement_dao.dart' as _i779;
import 'database/database.dart' as _i565;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i565.AppDatabase>(() => _i565.AppDatabase());
    gh.factory<_i666.SharedPreferencesManager>(
      () => _i666.SharedPreferencesManager(),
    );
    gh.factory<_i963.LocaleManager>(
      () => _i963.LocaleManager(gh<_i666.SharedPreferencesManager>()),
    );
    gh.factory<_i1044.ThemeManager>(
      () => _i1044.ThemeManager(gh<_i666.SharedPreferencesManager>()),
    );
    gh.factory<_i948.CurrencyManager>(
      () => _i948.CurrencyManager(gh<_i666.SharedPreferencesManager>()),
    );
    gh.factory<_i779.MovementDao>(
      () => _i779.MovementDao(gh<_i565.AppDatabase>()),
    );
    return this;
  }
}
