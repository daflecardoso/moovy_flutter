
import 'package:flutter/material.dart';

enum BottomTabs {
  movements,
  settings,
  profile,;

  String get title {
    switch (this) {
      case BottomTabs.movements:
        return 'Movements';
      case BottomTabs.settings:
        return 'Settings';
      case BottomTabs.profile:
        return 'Profile';
    }
  }

  IconData get icon {
    switch (this) {
      case BottomTabs.movements:
        return Icons.currency_exchange;
      case BottomTabs.settings:
        return Icons.settings;
      case BottomTabs.profile:
        return Icons.person;
    }
  }
}