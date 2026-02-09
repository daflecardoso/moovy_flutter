import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moovy/app_router.dart';
import 'package:moovy/database/domain/movement/movement.dart';
import 'package:moovy/di.dart';
import 'package:moovy/events/movement_changed.dart';
import 'package:moovy/extensions/int_extensions.dart';
import 'package:moovy/l10n/app_localizations.dart';
import 'package:moovy/main.dart';
import 'package:moovy/movement_list/view/movement_list_cubit.dart';
import 'package:moovy/movement_list/view/page/movement_list_page_cubit.dart';
import 'package:moovy/movement_list/view/widget/summary_widget.dart';
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
  bool get wantKeepAlive => true;
  late StreamSubscription<dynamic> event;

  @override
  void initState() {
    super.initState();
    cubit.getMovements(widget.month);
    event = eventBus.on<MovementChanged>().listen((event) {
      cubit.getMovements(widget.month);
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final appLocalization = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (_) => cubit,
      child: BlocBuilder<MovementListPageCubit, MovementListPageState>(
        builder: (_, state) {
          switch (state) {
            case MovementListPageInitial():
              return Center(child: CircularProgressIndicator());
            case MovementPageSuccess():
              return RefreshIndicator(
                onRefresh: () async {
                  cubit.getMovements(widget.month);
                },
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SummaryWidget(title: appLocalization.totalIncome, value: state.totalIncome.currency()),
                          SummaryWidget(title: appLocalization.totalExpense, value: state.totalExpense.currency()),
                          SummaryWidget(title: appLocalization.total, value: state.total.currency()),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.separated(
                        itemCount: state.movements.length,
                        itemBuilder: (_, index) {
                          final movement = state.movements[index];
                          return movementRow(movement);
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider(height: 1, thickness: 0.5);
                        },
                      ),
                    ),
                  ],
                ),
              );
            case MovementEmpty():
              return Padding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Spacer(),
                    Icon(LucideIcons.coins),
                    Text(appLocalization.emptyMovements, style: ShadTheme.of(context).textTheme.large),
                    Text(
                      appLocalization.youDonTHaveMovements(state.month),
                      style: ShadTheme.of(context).textTheme.blockquote,
                    ),
                    Spacer(),
                  ],
                ),
              );
            case MovementPageError():
              return Text(state.error);
          }
        },
      ),
    );
  }

  Widget movementRow(Movement movement) {
    return InkWell(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          spacing: 0,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: movement.imageUrl != null && movement.imageUrl!.isNotEmpty
                  ? ColorFiltered(
                      colorFilter: ColorFilter.mode(movement.paid ? Colors.grey : Colors.transparent, BlendMode.color),
                      child: Image.network(movement.imageUrl!, width: 30, height: 30),
                    )
                  : SizedBox(width: 30, height: 30),
            ),
            SizedBox(width: 8),
            Text(
              (movement.dueDay ?? movement.incomeDay ?? 0).toString().padLeft(2, '0'),
              style: ShadTheme.of(context).textTheme.small.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: movement.paid ? Colors.grey : null,
                decoration: movement.paid ? TextDecoration.lineThrough : TextDecoration.none,
              ),
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
                        fontWeight: FontWeight.w400,
                        color: movement.paid ? Colors.grey : null,
                        decoration: movement.paid ? TextDecoration.lineThrough : TextDecoration.none,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
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
                    color: movement.paid ? Colors.grey : movement.type.color,
                    decoration: movement.paid ? TextDecoration.lineThrough : TextDecoration.none,
                  ),
                ),
              ],
            ),
            SizedBox(width: 16),
            ShadCheckbox(
              size: 24,
              value: movement.paid,
              onChanged: (isChecked) {
                cubit.togglePaid(movement);
              },
            ),
            SizedBox(width: 8),
          ],
        ),
      ),
      onTap: () {
        context.router.navigatePath(
          '${AppRouter.incomeExpense}?id=${movement.id.toString()}&tab=${movement.type.name}&tabDate=${widget.month.date}',
        );
      },
    );
  }
}
