import 'package:moovy/app_router.dart';
import 'package:flutter/material.dart';
import 'package:moovy/di.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

void main() {
  configureDependencies();
  runApp(App());
}

class App extends StatelessWidget {
  final _appRouter = AppRouter();

  App({super.key});

  @override
  Widget build(BuildContext context) {
    return ShadApp.custom(
      themeMode: ThemeMode.dark,
      darkTheme: ShadThemeData(
          brightness: Brightness.dark, colorScheme: const ShadSlateColorScheme.dark()
      ),
      appBuilder: (context) {
        return MaterialApp.router(
          routerConfig: _appRouter.config(),
          theme: Theme.of(context),
          builder: (context, child) {
            return ShadAppBuilder(
              child: Material(
                child: child,
              ),
            );
          },
        );
      },
    );
  }
}
