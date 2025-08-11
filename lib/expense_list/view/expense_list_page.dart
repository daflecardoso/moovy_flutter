import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ExpenseListPage extends StatelessWidget {
  const ExpenseListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.grey.withValues(alpha: 0.1),
          child: ListTile(
            leading: Text('Day', style: ShadTheme.of(context).textTheme.small),
            title: Text('Description', style: ShadTheme.of(context).textTheme.small),
            trailing: Text("Amount", style: ShadTheme.of(context).textTheme.small),
            dense: true,
            visualDensity: VisualDensity.compact,
          ),
        ),
        Divider(height: 1),
        Expanded(
          child: ListView.separated(
            itemCount: 100,
            itemBuilder: (_, _) {
              return ListTile(
                leading: Text('10', style: ShadTheme.of(context).textTheme.small),
                title: Text('Installment Credit Card PF', style: ShadTheme.of(context).textTheme.small),
                trailing: Text("\$5600,90", style: ShadTheme.of(context).textTheme.list),
                onTap: () {},
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox.shrink();
            },
          ),
        ),
        Divider(height: 1),
        ListTile(
          leading: Text('Total', style: ShadTheme.of(context).textTheme.large),
          trailing: Text("\$50.000,00", style: ShadTheme.of(context).textTheme.large),
          onTap: () {},
        ),
      ],
    );
  }
}
