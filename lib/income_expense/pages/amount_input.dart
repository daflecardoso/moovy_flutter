
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:moovy/l10n/app_localizations.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class AmountInput extends StatelessWidget {
  final String? initialValue;
  const AmountInput({super.key, required this.initialValue});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return ShadInputFormField(
      id: 'amount',
      initialValue: initialValue,
      label: Text(appLocalizations.amount),
      placeholder: Text(appLocalizations.amountHint),
      description: Text(appLocalizations.amountDescription),
      keyboardType: TextInputType.number,
      leading: Icon(LucideIcons.coins),
      inputFormatters: [CurrencyTextInputFormatter.currency()],
      validator: (v) {
        if (v.isEmpty) {
          return appLocalizations.amountEmptyValue;
        }
        return null;
      },
    );
  }
}