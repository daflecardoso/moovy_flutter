import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moovy/app_router.dart';
import 'package:moovy/di.dart';
import 'package:moovy/main_cubit.dart';
import 'package:moovy/movement_list/view/movement_list_cubit.dart';
import 'package:moovy/movement_list/view/page/movement_list_page_screen.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

@RoutePage()
class MovementListScreen extends StatefulWidget {
  const MovementListScreen({super.key});

  @override
  State<StatefulWidget> createState() => _MovementListScreenState();
}

class _MovementListScreenState extends State<MovementListScreen>
    with SingleTickerProviderStateMixin<MovementListScreen> {
  late TabController _tabController;
  final MovementListCubit cubit = MovementListCubit(getIt.get());
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: cubit.months.length, initialIndex: cubit.tabIndex);
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
                      ShadIconButton.outline(
                        onPressed: () {
                          context.read<MainCubit>().toggleTheme();
                        },
                        icon: Icon(LucideIcons.sun),
                      ),
                      SizedBox(width: 16),
                      ShadIconButton.outline(
                        onPressed: () {
                          context.router.navigatePath(AppRouter.incomeExpense);
                        },
                        icon: const Icon(LucideIcons.plus),
                      ),
                      SizedBox(width: 16),
                    ],
                    bottom: TabBar(
                      controller: _tabController,
                      isScrollable: true,
                      tabAlignment: TabAlignment.start,
                      indicator: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelColor: Theme.of(context).colorScheme.onPrimary,
                      unselectedLabelColor: Theme.of(context).colorScheme.onSurfaceVariant,
                      dividerColor: Colors.transparent,
                      tabs: cubit.months.map((e) => Tab(text: e.title)).toList(),
                    ),
                  ),
                  body: TabBarView(
                    controller: _tabController,
                    children: cubit.months.map((e) => MovementListPage(month: e)).toList(),
                  ),
                ),
              );
          }
        },
      ),
    );
  }
}
