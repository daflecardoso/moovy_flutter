import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moovy/app_router.dart';
import 'package:moovy/database/domain/movement.dart';
import 'package:moovy/di.dart';
import 'package:moovy/extensions/date_time_extensions.dart';
import 'package:moovy/extensions/int_extensions.dart';
import 'package:moovy/movement_list/view/movement_list_cubit.dart';
import 'package:moovy/movement_list/view/page/movement_list_page_cubit.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class MovementListPage extends StatefulWidget {
  final MonthTab month;
  const MovementListPage({super.key, required this.month});

  @override
  State<MovementListPage> createState() => _MovementListPageState();
}

class _MovementListPageState extends State<MovementListPage> with AutomaticKeepAliveClientMixin {
  final cubit = MovementListPageCubit(getIt.get());

  @override
  void initState() {
    super.initState();
    cubit.getMovements(widget.month);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
      create: (_) => cubit,
      child: BlocBuilder<MovementListPageCubit, MovementListPageState>(
        builder: (_, state) {
          switch (state) {
            case MovementListPageInitial():
              return CircularProgressIndicator();
            case MovementPageSuccess():
              return RefreshIndicator(
                onRefresh: () async {
                  cubit.getMovements(widget.month);
                },
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        itemCount: state.movements.length,
                        itemBuilder: (_, index) {
                          final movement = state.movements[index];
                          return InkWell(
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: Row(
                                children: [
                                  Container(
                                    width: 40.0,
                                    height: 40.0,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withValues(alpha: 0.2),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(switch (movement.type) {
                                      MovementType.expense => LucideIcons.arrowBigUp,
                                      MovementType.income => LucideIcons.arrowBigDown,
                                    }),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 8),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          Text(
                                            movement.description,
                                            style: ShadTheme.of(context).textTheme.p.copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: movement.paid ? Colors.grey : null,
                                              decoration: movement.paid
                                                  ? TextDecoration.lineThrough
                                                  : TextDecoration.none,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            movement.type.name,
                                            style: ShadTheme.of(context).textTheme.small.copyWith(
                                              fontSize: 10,
                                              color: movement.paid ? Colors.grey : null,
                                              decoration: movement.paid
                                                  ? TextDecoration.lineThrough
                                                  : TextDecoration.none,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        movement.uiAmount,
                                        style: ShadTheme.of(context).textTheme.list.apply(
                                          color: movement.paid
                                              ? Colors.grey
                                              : switch (movement.type) {
                                                  MovementType.expense => Colors.redAccent,
                                                  MovementType.income => Colors.green,
                                                },
                                          decoration: movement.paid ? TextDecoration.lineThrough : TextDecoration.none,
                                        ),
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
                                  SizedBox(width: 8),
                                  ShadCheckbox(
                                    value: movement.paid,
                                    onChanged: (isChecked) {
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
                      trailing: Text(state.totalExpense.currency(), style: ShadTheme.of(context).textTheme.small),
                      dense: true,
                      visualDensity: VisualDensity.compact,
                      onTap: () {},
                    ),
                    ListTile(
                      leading: Text('Total Income', style: ShadTheme.of(context).textTheme.small),
                      trailing: Text(state.totalIncome.currency(), style: ShadTheme.of(context).textTheme.small),
                      dense: true,
                      visualDensity: VisualDensity.compact,
                      onTap: () {},
                    ),
                    ListTile(
                      leading: Text('Total', style: ShadTheme.of(context).textTheme.large),
                      trailing: Text(state.total.currency(), style: ShadTheme.of(context).textTheme.large),
                      dense: true,
                      visualDensity: VisualDensity.compact,
                      onTap: () {},
                    ),
                  ],
                ),
              );
          }
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
