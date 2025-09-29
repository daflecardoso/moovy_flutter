// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i8;
import 'package:flutter/material.dart' as _i9;
import 'package:moovy/income_expense/income_exepense_screen.dart' as _i2;
import 'package:moovy/income_expense/pages/expense_screen.dart' as _i1;
import 'package:moovy/income_expense/pages/income_screen.dart' as _i3;
import 'package:moovy/main/main_screen.dart' as _i4;
import 'package:moovy/movement_list/view/movement_list_screen.dart' as _i5;
import 'package:moovy/profile/profile_screen.dart' as _i6;
import 'package:moovy/settings/settings_screen.dart' as _i7;

/// generated route for
/// [_i1.ExpenseScreen]
class ExpenseRoute extends _i8.PageRouteInfo<void> {
  const ExpenseRoute({List<_i8.PageRouteInfo>? children})
    : super(ExpenseRoute.name, initialChildren: children);

  static const String name = 'ExpenseRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i1.ExpenseScreen();
    },
  );
}

/// generated route for
/// [_i2.IncomeExpenseScreen]
class IncomeExpenseRoute extends _i8.PageRouteInfo<IncomeExpenseRouteArgs> {
  IncomeExpenseRoute({
    _i9.Key? key,
    int? id,
    String tab = 'expense',
    List<_i8.PageRouteInfo>? children,
  }) : super(
         IncomeExpenseRoute.name,
         args: IncomeExpenseRouteArgs(key: key, id: id, tab: tab),
         rawPathParams: {'id': id},
         rawQueryParams: {'tab': tab},
         initialChildren: children,
       );

  static const String name = 'IncomeExpenseRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final queryParams = data.queryParams;
      final args = data.argsAs<IncomeExpenseRouteArgs>(
        orElse:
            () => IncomeExpenseRouteArgs(
              id: pathParams.optInt('id'),
              tab: queryParams.getString('tab', 'expense'),
            ),
      );
      return _i2.IncomeExpenseScreen(key: args.key, id: args.id, tab: args.tab);
    },
  );
}

class IncomeExpenseRouteArgs {
  const IncomeExpenseRouteArgs({this.key, this.id, this.tab = 'expense'});

  final _i9.Key? key;

  final int? id;

  final String tab;

  @override
  String toString() {
    return 'IncomeExpenseRouteArgs{key: $key, id: $id, tab: $tab}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! IncomeExpenseRouteArgs) return false;
    return key == other.key && id == other.id && tab == other.tab;
  }

  @override
  int get hashCode => key.hashCode ^ id.hashCode ^ tab.hashCode;
}

/// generated route for
/// [_i3.IncomeScreen]
class IncomeRoute extends _i8.PageRouteInfo<void> {
  const IncomeRoute({List<_i8.PageRouteInfo>? children})
    : super(IncomeRoute.name, initialChildren: children);

  static const String name = 'IncomeRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i3.IncomeScreen();
    },
  );
}

/// generated route for
/// [_i4.MainScreen]
class MainRoute extends _i8.PageRouteInfo<void> {
  const MainRoute({List<_i8.PageRouteInfo>? children})
    : super(MainRoute.name, initialChildren: children);

  static const String name = 'MainRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i4.MainScreen();
    },
  );
}

/// generated route for
/// [_i5.MovementListScreen]
class MovementListRoute extends _i8.PageRouteInfo<void> {
  const MovementListRoute({List<_i8.PageRouteInfo>? children})
    : super(MovementListRoute.name, initialChildren: children);

  static const String name = 'MovementListRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i5.MovementListScreen();
    },
  );
}

/// generated route for
/// [_i6.ProfileScreen]
class ProfileRoute extends _i8.PageRouteInfo<void> {
  const ProfileRoute({List<_i8.PageRouteInfo>? children})
    : super(ProfileRoute.name, initialChildren: children);

  static const String name = 'ProfileRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i6.ProfileScreen();
    },
  );
}

/// generated route for
/// [_i7.SettingsScreen]
class SettingsRoute extends _i8.PageRouteInfo<void> {
  const SettingsRoute({List<_i8.PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i7.SettingsScreen();
    },
  );
}
