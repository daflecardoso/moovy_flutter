import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moovy/di.dart';
import 'package:moovy/income_expense/income_expense_cubit.dart';
import 'package:moovy/income_expense/pages/expense_screen.dart';
import 'package:moovy/income_expense/pages/income_screen.dart';
import 'package:moovy/l10n/app_localizations.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

@RoutePage()
class IncomeExpenseScreen extends StatelessWidget {
  final int? id;
  final String tab;
  final String tabDate;
  const IncomeExpenseScreen({super.key, @PathParam('id') this.id, @QueryParam('tab') this.tab = 'expense', @QueryParam('tabDate') this.tabDate = ''});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final tab = IncomeExpenseTabs.values.firstWhere((e) => e.name == this.tab);
    final cubit = IncomeExpenseCubit(getIt.get(), id, tab);
    return BlocProvider(
      create: (context) => cubit,
      child: Scaffold(
        appBar: AppBar(title: Text(appLocalizations.incomeExpense, style: ShadTheme.of(context).textTheme.large)),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: ShadTabs(
              value: tab,
              tabBarConstraints: const BoxConstraints(maxWidth: 450),
              contentConstraints: const BoxConstraints(maxWidth: 450),
              onChanged: (value) {
                cubit.setTab(value);
              },
              tabs: [
                ShadTab(
                  value: IncomeExpenseTabs.expense,
                  content: ExpenseScreen(tabDate: DateTime.parse(tabDate)),
                  child: Text(appLocalizations.expense),
                ),
                ShadTab(
                  value: IncomeExpenseTabs.income,
                  content: IncomeScreen(),
                  child: Text(appLocalizations.income),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
