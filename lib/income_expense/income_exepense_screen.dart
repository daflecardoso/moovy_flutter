import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moovy/di.dart';
import 'package:moovy/income_expense/income_expense_cubit.dart';
import 'package:moovy/income_expense/pages/expense_screen.dart';
import 'package:moovy/income_expense/pages/income_screen.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

@RoutePage()
class IncomeExpenseScreen extends StatelessWidget {
  final int? id;
  final String tab;
  const IncomeExpenseScreen({super.key, @PathParam('id') this.id, @QueryParam('tab') this.tab = 'expense'});

  @override
  Widget build(BuildContext context) {
    final tab = IncomeExpenseTabs.values.firstWhere((e) => e.name == this.tab);
    final cubit = IncomeExpenseCubit(getIt.get(), id, tab);
    return BlocProvider(
      create: (context) => cubit,
      child: Scaffold(
        appBar: AppBar(title: Text('Income Expense', style: ShadTheme.of(context).textTheme.large)),
        body: Padding(
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
                content: ExpenseScreen(),
                child: Text('Expense'),
              ),
              ShadTab(
                value: IncomeExpenseTabs.income,
                content: IncomeScreen(),
                child: Text('Income'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
