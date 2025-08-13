import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moovy/extensions/int_extensions.dart';
import 'package:moovy/income_expense/income_expense_cubit.dart';
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
                    ShadInputFormField(
                      id: 'description',
                      initialValue: state.expense?.description,
                      label: const Text('Income Description'),
                      placeholder: const Text('Ex: Salary'),
                      description: const Text('This is your income description.'),
                      leading: Icon(LucideIcons.text),
                      validator: (v) {
                        if (v.isEmpty) {
                          return 'Description of expense cannot be empty.';
                        }
                        return null;
                      },
                    ),
                    ShadDatePickerFormField(
                      id: 'incomeDate',
                      initialValue: state.expense?.incomeDate,
                      label: const Text('Income date'),
                      width: 450,
                      validator: (v) {
                        if (v == null) return 'Due date is required.';
                        return null;
                      },
                    ),
                    ShadDateRangePickerFormField(
                      id: 'period',
                      initialValue: ShadDateTimeRange(start: state.expense?.startDate, end: state.expense?.endDate),
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
                    ShadInputFormField(
                      id: 'amount',
                      initialValue: state.expense?.amount.currency(),
                      label: const Text('Amount'),
                      placeholder: const Text('Ex: \$150,00'),
                      description: const Text('Amount per month'),
                      keyboardType: TextInputType.number,
                      leading: Icon(LucideIcons.coins),
                      inputFormatters: [CurrencyTextInputFormatter.currency()],
                      validator: (v) {
                        if (v.isEmpty) {
                          return 'Please type some value.';
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
                              context.router.popForced();
                            },
                          ),
                        ShadButton(
                          child: const Text('Save'),
                          onPressed: () async {
                            if (formKey.currentState!.saveAndValidate()) {
                              debugPrint('validation succeeded with ${formKey.currentState!.value}');
                              final cubit = context.read<IncomeExpenseCubit>();
                              await cubit.createMovement(data: formKey.currentState!.value);
                              this.context.router.popForced();
                            } else {
                              debugPrint('validation failed');
                            }
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
        }
      },
    );
  }
}
