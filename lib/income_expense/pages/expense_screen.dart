import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moovy/database/domain/movement.dart';
import 'package:moovy/extensions/int_extensions.dart';
import 'package:moovy/income_expense/income_expense_cubit.dart';
import 'package:moovy/income_expense/pages/amount_input.dart';
import 'package:moovy/income_expense/pages/description_field.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

@RoutePage()
class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({super.key});

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  final formKey = GlobalKey<ShadFormState>();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<IncomeExpenseCubit>();
    return BlocBuilder<IncomeExpenseCubit, IncomeExpenseState>(
      builder: (context, state) {
        switch (state) {
          case IncomeExpenseInitial():
            return SizedBox.shrink();
          case IncomeExpenseForm():
            return ShadForm(
              key: formKey,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 450),
                child: Column(
                  spacing: 16,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ShadBadge(
                      backgroundColor: MovementType.expense.color,
                      child: const Text('Expense'),
                    ),
                    DescriptionInput(
                        initialValue: state.expense?.description,
                        title: 'Expense Description',
                        placeholder: 'Ex: Invoice Credit Card',
                    ),
                    AmountInput(initialValue: state.expense?.amount.currency()),
                    ShadInputFormField(
                      id: 'dueDay',
                      initialValue: state.expense?.dueDay.toString(),
                      label: const Text('Due day of expense'),
                      placeholder: Text('Ex: 10'),
                      keyboardType: TextInputType.number,
                      validator: (v) {
                        if (v.isEmpty) return 'Due day is required.';
                        return null;
                      },
                    ),
                    ShadDateRangePickerFormField(
                      id: 'period',
                      initialValue: ShadDateTimeRange(start: state.expense?.startDate, end: state.expense?.endDate),
                      label: const Text('Period of expense'),
                      width: 450,
                      description: const Text('If has not end date, pick the start date.'),
                      validator: (v) {
                        if (v == null) return 'Start or range of dates is required.';
                        if (v.start == null) {
                          return 'The start date is required.';
                        }
                        return null;
                      },
                    ),
                    Row(
                      spacing: 16,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (cubit.id != null)
                          ShadButton.outline(
                            child: const Text('Delete'),
                            onPressed: () {
                              cubit.delete();
                              context.router.pop();
                            },
                          ),
                        ShadButton(
                          child: const Text('Save'),
                          onPressed: () async {
                            if (formKey.currentState!.saveAndValidate()) {
                              debugPrint('validation succeeded with ${formKey.currentState!.value}');
                              final cubit = context.read<IncomeExpenseCubit>();
                              await cubit.createMovement(data: formKey.currentState!.value);
                              this.context.router.pop();
                            } else {
                              debugPrint('validation failed');
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
        }
      },
    );
  }
}
