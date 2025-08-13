import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moovy/app_router.dart';
import 'package:moovy/database/domain/movement.dart';
import 'package:moovy/extensions/date_time_extensions.dart';
import 'package:moovy/extensions/int_extensions.dart';
import 'package:moovy/movement_list/view/movement_list_cubit.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class MovementListPage extends StatelessWidget {
  final List<Movement> movements;
  final int totalExpense, totalIncome, total;
  const MovementListPage({
    super.key,
    required this.movements,
    required this.totalIncome,
    required this.totalExpense,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        final cubit = context.read<MovementListCubit>();
        cubit.onTabChange(cubit.tabIndex);
      },
      child: Column(
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
                  leading: Text(
                    movement.dueDate?.format(DateTimeFormat.dd) ??
                        movement.incomeDate?.format(DateTimeFormat.dd) ??
                        '-',
                    style: ShadTheme.of(context).textTheme.small,
                  ),
                  title: Text(movement.description, style: ShadTheme.of(context).textTheme.small),
                  trailing: Text(
                    movement.amount.currency(),
                    style: ShadTheme.of(context).textTheme.list.apply(
                      color: switch (movement.type) {
                        MovementType.expense => Colors.orange,
                        MovementType.income => Colors.green,
                      },
                    ),
                  ),
                  onTap: () {
                    context.router.navigateNamed(
                      '${AppRouter.incomeExpense.replaceAll(':id', movement.id.toString())}?tab=${movement.type.name}',
                    );
                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox.shrink();
              },
            ),
          ),
          Divider(height: 1),
          ListTile(
            leading: Text('Total Expense', style: ShadTheme.of(context).textTheme.small),
            trailing: Text(totalExpense.currency(), style: ShadTheme.of(context).textTheme.small),
            dense: true,
            visualDensity: VisualDensity.compact,
            onTap: () {},
          ),
          ListTile(
            leading: Text('Total Income', style: ShadTheme.of(context).textTheme.small),
            trailing: Text(totalIncome.currency(), style: ShadTheme.of(context).textTheme.small),
            dense: true,
            visualDensity: VisualDensity.compact,
            onTap: () {},
          ),
          ListTile(
            leading: Text('Total', style: ShadTheme.of(context).textTheme.large),
            trailing: Text(total.currency(), style: ShadTheme.of(context).textTheme.large),
            dense: true,
            visualDensity: VisualDensity.compact,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
