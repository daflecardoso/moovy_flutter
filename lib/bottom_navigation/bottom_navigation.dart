import 'package:flutter/material.dart';
import 'package:moovy/bottom_navigation/bottom_tabs.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class BottomNavigation extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int>? onDestinationSelected;
  const BottomNavigation({super.key, required this.selectedIndex, this.onDestinationSelected});

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    return SafeArea(
      child: Container(
        width: 200,
        height: 56,
        margin: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          color: colors.background,
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          boxShadow: [
            BoxShadow(color: Colors.grey.withValues(alpha: 0.3), offset: const Offset(0, 10), blurRadius: 40),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: NavigationBar(
            indicatorColor: colors.accent,
            backgroundColor: Colors.transparent,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
            selectedIndex: selectedIndex,
            onDestinationSelected: onDestinationSelected,
            destinations: BottomTabs.values.indexed
                .map(
                  (item) => NavigationDestination(
                    icon: Icon(
                      item.$2.icon,
                      color: selectedIndex == item.$1
                          ? colors.primary
                          : colors.secondaryForeground.withValues(alpha: 0.3),
                    ),
                    label: item.$2.title,
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
