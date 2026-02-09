import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moovy/database/domain/movement/movement.dart';
import 'package:moovy/extensions/int_extensions.dart';
import 'package:moovy/income_expense/income_expense_cubit.dart';
import 'package:moovy/income_expense/occurrence.dart';
import 'package:moovy/income_expense/pages/amount_input.dart';
import 'package:moovy/income_expense/pages/description_field.dart';
import 'package:moovy/income_expense/pages/image_url_field.dart';
import 'package:moovy/l10n/app_localizations.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

@RoutePage()
class IncomeScreen extends StatefulWidget {
  final DateTime tabDate;
  const IncomeScreen({super.key, required this.tabDate});

  @override
  State<IncomeScreen> createState() => _IncomeScreenState();
}

class _IncomeScreenState extends State<IncomeScreen> {
  final formKey = GlobalKey<ShadFormState>();

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
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
                    ShadBadge(backgroundColor: MovementType.income.color, child: Text(appLocalizations.income)),
                    ImageUrlField(
                      initialValue: state.income?.imageUrl,
                    ),
                    DescriptionInput(
                      initialValue: state.income?.description,
                      title: appLocalizations.incomeDescription,
                      placeholder: appLocalizations.incomeHint,
                    ),
                    AmountInput(initialValue: state.income?.amount.currency()),
                    ShadInputFormField(
                      id: 'incomeDay',
                      initialValue: state.income?.incomeDay?.toString(),
                      label: Text(appLocalizations.incomeDay),
                      placeholder: Text(appLocalizations.dueDayExpenseHint),
                      validator: (v) {
                        if (v.isEmpty) return appLocalizations.incomeDayIsRequired;
                        return null;
                      },
                    ),
                    ShadDateRangePickerFormField(
                      id: 'period',
                      initialValue: ShadDateTimeRange(start: state.income?.startDate, end: state.income?.endDate),
                      label: Text(appLocalizations.periodOfIncome),
                      width: 450,
                      description: Text(appLocalizations.periodOfExpenseDescription),
                      validator: (v) {
                        if (v?.start == null) {
                          return appLocalizations.startDateOrRangeIsRequired;
                        }
                        return null;
                      },
                    ),
                    if (state.income != null)
                      Row(
                        children: [
                          ShadRadioGroupFormField<Occurrence>(
                            id: 'occurrence',
                            initialValue: state.income != null
                                ? state.income!.isSameMonthYear()
                                ? Occurrence.it
                                : null
                                : null,
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
                              if (state.income == null) {
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
