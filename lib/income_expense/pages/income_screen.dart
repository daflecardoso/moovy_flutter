import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moovy/database/domain/movement/movement.dart';
import 'package:moovy/extensions/int_extensions.dart';
import 'package:moovy/income_expense/income_expense_cubit.dart';
import 'package:moovy/income_expense/pages/amount_input.dart';
import 'package:moovy/income_expense/pages/description_field.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

@RoutePage()
class IncomeScreen extends StatefulWidget {
  const IncomeScreen({super.key});

  @override
  State<IncomeScreen> createState() => _IncomeScreenState();
}

class _IncomeScreenState extends State<IncomeScreen> {
  final formKey = GlobalKey<ShadFormState>();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<IncomeExpenseCubit>();
    return BlocBuilder<IncomeExpenseCubit, IncomeExpenseState>(
      builder: (BuildContext context, IncomeExpenseState state) {
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
                    ShadBadge(backgroundColor: MovementType.income.color, child: const Text('Income')),
                    DescriptionInput(
                      initialValue: state.income?.description,
                      title: 'Income Description',
                      placeholder: 'Ex: Salary',
                    ),
                    AmountInput(initialValue: state.income?.amount.currency()),
                    ShadInputFormField(
                      id: 'incomeDay',
                      initialValue: state.income?.incomeDay?.toString(),
                      label: const Text('Income day'),
                      placeholder: Text('Ex: 10'),
                      validator: (v) {
                        if (v.isEmpty) return 'Income day is required.';
                        return null;
                      },
                    ),
                    ShadDateRangePickerFormField(
                      id: 'period',
                      initialValue: ShadDateTimeRange(start: state.income?.startDate, end: state.income?.endDate),
                      label: const Text('Period of income'),
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
