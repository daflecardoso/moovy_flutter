import 'package:moovy/app_router.dart';
import 'package:moovy/di.dart';
import 'package:moovy/expense_list/view/expense_list_cubit.dart';
import 'package:moovy/expense_list/view/expense_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class ExpenseListScreen extends StatefulWidget {
  const ExpenseListScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ExpenseListScreenState();
}

class _ExpenseListScreenState extends State<ExpenseListScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ExpenseListCubit cubit = ExpenseListCubit(getIt.get());
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: cubit.months.length, initialIndex: cubit.initialIndex-1);
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
      child: BlocBuilder<ExpenseListCubit, ExpenseListState>(
        builder: (BuildContext context, ExpenseListState state) {
          switch (state) {
            case ExpenseListInitial():
              return SizedBox.shrink();
            case ExpenseListSuccess():
              return SafeArea(
                child: Scaffold(
                  appBar: AppBar(
                    title: Text('Expenses', style: ShadTheme.of(context).textTheme.large),
                    actions: [
                      Padding(
                        padding: EdgeInsets.only(right: 16),
                        child: ShadIconButton(
                          onPressed: () {
                            context.router.navigatePath(AppRouter.incomeExpense);
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
                    children: cubit.months.map((e) => ExpenseListPage(movements: state.movements)).toList(),
                  ),
                ),
              );
          }
        },
      ),
    );
  }
}
