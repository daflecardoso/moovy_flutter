
import 'package:flutter/cupertino.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class SummaryWidget extends StatelessWidget {
  final String title, value;

  const SummaryWidget({super.key,  required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title, style: ShadTheme.of(context).textTheme.muted),
        Text(value, style: ShadTheme.of(context).textTheme.small),
      ],
    );
  }
}