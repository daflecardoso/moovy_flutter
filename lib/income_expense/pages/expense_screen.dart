import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moovy/database/domain/movement/movement.dart';
import 'package:moovy/extensions/date_time_extensions.dart';
import 'package:moovy/extensions/int_extensions.dart';
import 'package:moovy/income_expense/income_expense_cubit.dart';
import 'package:moovy/income_expense/occurrence.dart';
import 'package:moovy/income_expense/pages/amount_input.dart';
import 'package:moovy/income_expense/pages/description_field.dart';
import 'package:moovy/income_expense/pages/image_url_field.dart';
import 'package:moovy/l10n/app_localizations.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

@RoutePage()
class ExpenseScreen extends StatefulWidget {
  final DateTime tabDate;
  const ExpenseScreen({super.key, required this.tabDate});

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  final formKey = GlobalKey<ShadFormState>();

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
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
                    Row(
                      children: [
                        ShadDateRangePickerFormField(
                          id: 'tabDate',
                          enabled: false,
                          formatDateRange: (_) => widget.tabDate.format(DateTimeFormat.mmmmYyyy),
                          initialValue: ShadDateTimeRange(start: widget.tabDate),
                        ),
                        Spacer(),
                        ShadBadge(backgroundColor: MovementType.expense.color, child: Text(appLocalizations.expense)),
                      ],
                    ),
                    ImageUrlField(initialValue: state.expense?.imageUrl),
                    DescriptionInput(
                      initialValue: state.expense?.description,
                      title: appLocalizations.expenseDescription,
                      placeholder: appLocalizations.expenseDescriptionHint,
                    ),
                    AmountInput(initialValue: state.expense?.amount.currency()),
                    ShadInputFormField(
                      id: 'dueDay',
                      initialValue: state.expense?.dueDay.toString(),
                      label: Text(appLocalizations.dueDayExpense),
                      placeholder: Text(appLocalizations.dueDayExpenseHint),
                      keyboardType: TextInputType.number,
                      validator: (v) {
                        if (v.isEmpty) return appLocalizations.dueDayIsRequired;
                        return null;
                      },
                    ),
                    ShadDateRangePickerFormField(
                      id: 'period',
                      initialValue: ShadDateTimeRange(start: state.expense?.startDate, end: state.expense?.endDate),
                      label: Text(appLocalizations.periodOfExpense),
                      width: 450,
                      initialMonth: widget.tabDate,
                      description: Text(appLocalizations.periodOfExpenseDescription),
                      validator: (v) {
                        if (v == null) return appLocalizations.startDateOrRangeIsRequired;
                        return null;
                      },
                    ),
                    if (state.expense != null)
                      Row(
                        children: [
                          ShadRadioGroupFormField<Occurrence>(
                            id: 'occurrence',
                            initialValue: state.expense?.getOccurrence(),
                            spacing: 16,
                            label: Text(appLocalizations.occurrences),
                            items: Occurrence.values.map(
                              (e) => ShadRadio(
                                value: e,
                                label: Text(switch (e) {
                                  Occurrence.it => appLocalizations.updateJustIt,
                                  Occurrence.all => appLocalizations.updateAppOccurrences,
                                }),
                              ),
                            ),
                            validator: (v) {
                              if (state.expense == null) {
                                return null;
                              }
                              if (v == null) {
                                return appLocalizations.youMustPickAnOption;
                              }
                              return null;
                            },
                          ),
                          Spacer(),
                        ],
                      ),
                    Row(
                      spacing: 16,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (cubit.id != null)
                          ShadButton.outline(
                            child: Text(appLocalizations.delete),
                            onPressed: () {
                              cubit.delete();
                              context.router.pop();
                            },
                          ),
                        ShadButton(
                          child: Text(appLocalizations.save),
                          onPressed: () async {
                            debugPrint(formKey.currentState!.value.toString());
                            if (formKey.currentState!.saveAndValidate()) {
                              final cubit = context.read<IncomeExpenseCubit>();
                              await cubit.save(data: formKey.currentState!.value, monthTab: widget.tabDate);
                              this.context.router.pop();
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
