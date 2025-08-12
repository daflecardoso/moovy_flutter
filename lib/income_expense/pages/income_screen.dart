import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return ShadForm(
      key: formKey,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 350),
        child: Column(
          spacing: 16,
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            ShadInputFormField(
              id: 'description',
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
              label: const Text('Income date'),
              width: 350,
              validator: (v) {
                if (v == null) return 'Due date is required.';
                return null;
              },
            ),
            ShadDateRangePickerFormField(
              id: 'period',
              label: const Text('Period of income'),
              width: 350,
              description: const Text(
                'If has not end date, pick the start date.',
              ),
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
            ShadButton(
              child: const Text('Save'),
              onPressed: () async {
                if (formKey.currentState!.saveAndValidate()) {
                  debugPrint(
                    'validation succeeded with ${formKey.currentState!.value}',
                  );
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
      ),
    );
  }
}
