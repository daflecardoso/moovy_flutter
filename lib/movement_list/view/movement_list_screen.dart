import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moovy/app_router.dart';
import 'package:moovy/di.dart';
import 'package:moovy/l10n/app_localizations.dart';
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
    final appLocalizations = AppLocalizations.of(context)!;

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
                    title: Text(appLocalizations.movements, style: ShadTheme.of(context).textTheme.large),
                    actions: [
                      ShadIconButton.outline(
                        onPressed: () {
                          context.router.navigatePath('${AppRouter.incomeExpense}?tabDate=${cubit.months[_tabController.index].date}');
                        },
                        icon: const Icon(LucideIcons.plus),
                      ),
                      SizedBox(width: 16),
                    ],
                    bottom: TabBar(
                      controller: _tabController,
                      isScrollable: true,
                      tabAlignment: TabAlignment.start,
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelColor: Theme.of(context).colorScheme.onSurfaceVariant,
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
