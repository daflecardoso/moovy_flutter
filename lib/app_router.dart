import 'package:auto_route/auto_route.dart';
import 'package:moovy/app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  static const incomeExpense = '/income-expense';
  static const expenses = '/expenses';
  static const expense = '/expense';
  static const profile = '/profile';

  @override
  List<AutoRoute> get routes => [
    AutoRoute(path: expenses, page: ExpenseListRoute.page, initial: true),
    AutoRoute(path: incomeExpense, page: IncomeExpenseRoute.page),
    AutoRoute(path: expense, page: ExpenseRoute.page),
  ];

  @override
  List<AutoRouteGuard> get guards => [];
}
