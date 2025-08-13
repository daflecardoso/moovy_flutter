
import 'package:flutter/cupertino.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class DescriptionInput extends StatelessWidget {
  final String title, placeholder;
  final String? initialValue;
  const DescriptionInput({super.key, required this.initialValue, required this.title, required this.placeholder });

  @override
  Widget build(BuildContext context) {
    return ShadInputFormField(
      id: 'description',
      initialValue: initialValue,
      label: Text(title),
      placeholder: Text(placeholder),
      leading: Icon(LucideIcons.text),
      validator: (v) {
        if (v.isEmpty) {
          return 'Description of cannot be empty.';
        }
        return null;
      },
    );
  }

}