import 'package:auto_route/auto_route.dart';
import 'package:moovy/app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  static const main = '/main';
  static const incomeExpense = '/income-expense/:id';
  static const movements = 'movements';
  static const settings = 'settings';
  static const expense = '/expense';
  static const profile = 'profile';

  @override
  List<AutoRoute> get routes => [
    AutoRoute(path: main, page: MainRoute.page, initial: true, children: [
      AutoRoute(path: movements, page: MovementListRoute.page),
      AutoRoute(path: profile, page: ProfileRoute.page),
      AutoRoute(path: settings, page: SettingsRoute.page),
    ]),
    AutoRoute(path: incomeExpense, page: IncomeExpenseRoute.page),
    AutoRoute(path: expense, page: ExpenseRoute.page),
  ];

  @override
  List<AutoRouteGuard> get guards => [];
}
