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
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                spacing: 16,
                children: [
                  Text('Type', style: ShadTheme.of(context).textTheme.small),
                  Expanded(child: Text('Description', style: ShadTheme.of(context).textTheme.small)),
                  Text("Amount", style: ShadTheme.of(context).textTheme.small),
                  Text("Paid", style: ShadTheme.of(context).textTheme.small),
                ],
              ),
            ),
          ),
          Divider(height: 1),
          Expanded(
            child: ListView.separated(
              itemCount: movements.length,
              itemBuilder: (_, index) {
                final movement = movements[index];
                return InkWell(
                  child: Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Row(
                      children: [
                        Icon(switch (movement.type) {
                          MovementType.expense => LucideIcons.arrowBigUp,
                          MovementType.income => LucideIcons.arrowBigDown,
                        }),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  movement.description,
                                  style: ShadTheme.of(context).textTheme.p.copyWith(
                                    color: movement.paid ? Colors.grey : null,
                                    decoration: movement.paid ? TextDecoration.lineThrough : TextDecoration.none,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  movement.dueDate?.format(DateTimeFormat.ddMM) ??
                                      movement.incomeDate?.format(DateTimeFormat.ddMM) ??
                                      '-',
                                  style: ShadTheme.of(context).textTheme.small.copyWith(
                                    fontSize: 10,
                                    color: movement.paid ? Colors.grey : null,
                                    decoration: movement.paid ? TextDecoration.lineThrough : TextDecoration.none,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Text(
                          movement.amount.currency(),
                          style: ShadTheme.of(context).textTheme.list.apply(
                            color: movement.paid
                                ? Colors.grey
                                : switch (movement.type) {
                                    MovementType.expense => Colors.orange,
                                    MovementType.income => Colors.green,
                                  },
                            decoration: movement.paid ? TextDecoration.lineThrough : TextDecoration.none,
                          ),
                        ),
                        Checkbox(
                          value: movement.paid,
                          onChanged: (isChecked) {
                            final cubit = context.read<MovementListCubit>();
                            cubit.togglePaid(movement);
                          },
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    context.router.navigatePath(
                      '${AppRouter.incomeExpense.replaceAll(':id', movement.id.toString())}?tab=${movement.type.name}',
                    );
                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider(height: 1);
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
