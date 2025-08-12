// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:moovy/income_expense/pages/expense_screen.dart' as _i2;
import 'package:moovy/expense_list/view/expense_list_screen.dart' as _i1;
import 'package:moovy/income_expense/pages/income_screen.dart' as _i4;
import 'package:moovy/income_expense/income_exepense_screen.dart' as _i3;
import 'package:moovy/profile/profile_screen.dart' as _i5;

/// generated route for
/// [_i1.ExpenseListScreen]
class ExpenseListRoute extends _i6.PageRouteInfo<void> {
  const ExpenseListRoute({List<_i6.PageRouteInfo>? children})
    : super(ExpenseListRoute.name, initialChildren: children);

  static const String name = 'ExpenseListRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i1.ExpenseListScreen();
    },
  );
}

/// generated route for
/// [_i2.ExpenseScreen]
class ExpenseRoute extends _i6.PageRouteInfo<void> {
  const ExpenseRoute({List<_i6.PageRouteInfo>? children})
    : super(ExpenseRoute.name, initialChildren: children);

  static const String name = 'ExpenseRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i2.ExpenseScreen();
    },
  );
}

/// generated route for
/// [_i3.IncomeExpenseScreen]
class IncomeExpenseRoute extends _i6.PageRouteInfo<void> {
  const IncomeExpenseRoute({List<_i6.PageRouteInfo>? children})
    : super(IncomeExpenseRoute.name, initialChildren: children);

  static const String name = 'IncomeExpenseRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i3.IncomeExpenseScreen();
    },
  );
}

/// generated route for
/// [_i4.IncomeScreen]
class IncomeRoute extends _i6.PageRouteInfo<void> {
  const IncomeRoute({List<_i6.PageRouteInfo>? children})
    : super(IncomeRoute.name, initialChildren: children);

  static const String name = 'IncomeRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i4.IncomeScreen();
    },
  );
}

/// generated route for
/// [_i5.ProfileScreen]
class ProfileRoute extends _i6.PageRouteInfo<void> {
  const ProfileRoute({List<_i6.PageRouteInfo>? children})
    : super(ProfileRoute.name, initialChildren: children);

  static const String name = 'ProfileRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i5.ProfileScreen();
    },
  );
}
