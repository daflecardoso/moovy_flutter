import 'package:flutter/material.dart';
import 'package:moovy/database/domain/movement.dart';
import 'package:moovy/extensions/date_time_extensions.dart';
import 'package:moovy/extensions/int_extensions.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ExpenseListPage extends StatelessWidget {
  final List<Movement> movements;
  const ExpenseListPage({super.key, required this.movements});

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
            itemCount: movements.length,
            itemBuilder: (_, index) {
              final movement = movements[index];
              return ListTile(
                leading: Text(movement.dueDate?.format(DateTimeFormat.dd) ?? '-', style: ShadTheme.of(context).textTheme.small),
                title: Text(movement.description, style: ShadTheme.of(context).textTheme.small),
                trailing: Text(movement.amount.currency(), style: ShadTheme.of(context).textTheme.list),
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
