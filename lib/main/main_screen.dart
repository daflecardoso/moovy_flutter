
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:moovy/app_router.gr.dart';
import 'package:moovy/bottom_navigation/bottom_navigation.dart';

@RoutePage()
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: [
        MovementListRoute(),
        SettingsRoute(),
        ProfileRoute()
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          body: child,
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: BottomNavigation(
            selectedIndex: tabsRouter.activeIndex,
            onDestinationSelected: (index) {
              tabsRouter.setActiveIndex(index);
            },
          ),
        );
      },
    );
  }
}