import 'package:event_bus/event_bus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moovy/app_router.dart';
import 'package:moovy/di.dart';
import 'package:moovy/firebase_options.dart';
import 'package:moovy/main_cubit.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

final eventBus = EventBus();
var globalCurrencyFormat = NumberFormat.currency();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final app = await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseAuth.instanceFor(app: app);
  configureDependencies();
  runApp(App());
}

class App extends StatelessWidget {
  final _appRouter = AppRouter();

  App({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = MainCubit(getIt.get(), getIt.get(), getIt.get(), getIt.get())..setup();
    return BlocProvider(
      create: (BuildContext context) => cubit,
      child: BlocBuilder<MainCubit, MainState>(
        builder: (BuildContext context, MainState state) {
          switch (state) {
            case MainInitial():
              return Center(child: CircularProgressIndicator());
            case MainLoaded():
              return ShadApp.custom(
                themeMode: state.themeMode,
                darkTheme: ShadThemeData(brightness: Brightness.dark, colorScheme: const ShadSlateColorScheme.dark()),
                appBuilder: (context) {
                  return MaterialApp.router(
                    debugShowCheckedModeBanner: false,
                    routerConfig: _appRouter.config(),
                    theme: Theme.of(context),
                    supportedLocales: state.supportedLocales,
                    localizationsDelegates: state.localizationDelegate,
                    builder: (context, child) {
                      return MaterialApp(
                        theme: Theme.of(context),
                        debugShowCheckedModeBanner: false,
                        home: ShadAppBuilder(child: Material(child: child)),
                        locale: state.locale,
                        supportedLocales: state.supportedLocales,
                        localizationsDelegates: state.localizationDelegate,
                      );
                    },
                  );
                },
              );
          }
        },
      ),
    );
  }
}
