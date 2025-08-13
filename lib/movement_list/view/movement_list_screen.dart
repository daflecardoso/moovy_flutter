import 'package:moovy/app_router.dart';
import 'package:moovy/di.dart';
import 'package:moovy/movement_list/view/movement_list_cubit.dart';
import 'package:moovy/movement_list/view/movement_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class MovementListScreen extends StatefulWidget {
  const MovementListScreen({super.key});

  @override
  State<StatefulWidget> createState() => _MovementListScreenState();
}

class _MovementListScreenState extends State<MovementListScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final MovementListCubit cubit = MovementListCubit(getIt.get());
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: cubit.months.length, initialIndex: cubit.tabIndex);
    _tabController.addListener(() {
      if (_tabController.index == _tabController.animation?.value.round()) {
        cubit.onTabChange(_tabController.index);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => cubit,
      child: BlocBuilder<MovementListCubit, MovementListState>(
        builder: (BuildContext context, MovementListState state) {
          switch (state) {
            case MovementListInitial():
              return SizedBox.shrink();
            case MovementListSuccess():
              return SafeArea(
                child: Scaffold(
                  appBar: AppBar(
                    title: Text('Movements', style: ShadTheme.of(context).textTheme.large),
                    actions: [
                      Padding(
                        padding: EdgeInsets.only(right: 16),
                        child: ShadIconButton(
                          onPressed: () {
                            context.router.navigateNamed(AppRouter.incomeExpense);
                          },
                          icon: const Icon(LucideIcons.plus),
                        ),
                      ),
                    ],
                    bottom: TabBar(
                      dividerHeight: 2,
                      dividerColor: Colors.grey.withValues(alpha: 0.2),
                      tabAlignment: TabAlignment.start,
                      isScrollable: true,
                      controller: _tabController,
                      unselectedLabelStyle: ShadTheme.of(context).textTheme.small,
                      labelStyle: ShadTheme.of(context).textTheme.large,
                      indicatorPadding: EdgeInsets.zero,
                      tabs: cubit.months.map((e) => Tab(text: e.title)).toList(),
                    ),
                  ),
                  body: TabBarView(
                    controller: _tabController,
                    children: cubit.months
                        .map(
                          (e) => MovementListPage(
                            movements: state.movements,
                            totalExpense: state.totalExpense,
                            totalIncome: state.totalIncome,
                            total: state.total,
                          ),
                        )
                        .toList(),
                  ),
                ),
              );
          }
        },
      ),
    );
  }
}
