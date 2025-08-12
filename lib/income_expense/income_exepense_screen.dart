import 'package:auto_route/annotations.dart';
import 'package:moovy/income_expense/pages/expense_screen.dart';
import 'package:moovy/income_expense/pages/income_screen.dart';
import 'package:moovy/income_expense/income_expense_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

@RoutePage()
class IncomeExpenseScreen extends StatelessWidget {
  const IncomeExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => IncomeExpenseCubit(),
      child: BlocBuilder<IncomeExpenseCubit, IncomeExpenseState>(
        builder: (context, state) {
          switch (state) {
            case IncomeExpenseInitial():
              return Scaffold(
                appBar: AppBar(
                  title: Text(
                    'Income Expense',
                    style: ShadTheme.of(context).textTheme.large,
                  ),
                ),
                body: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: ShadTabs(
                    value: IncomeExpenseTabs.expense,
                    tabBarConstraints: const BoxConstraints(maxWidth: 400),
                    contentConstraints: const BoxConstraints(maxWidth: 400),
                    onChanged: (value) {
                      context.read<IncomeExpenseCubit>().setTab(value);
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
              );
          }
        },
      ),
    );
  }
}
