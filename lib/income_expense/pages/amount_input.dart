
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class AmountInput extends StatelessWidget {
  final String? initialValue;
  const AmountInput({super.key, required this.initialValue});

  @override
  Widget build(BuildContext context) {
    return ShadInputFormField(
      id: 'amount',
      initialValue: initialValue,
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
    );
  }
}