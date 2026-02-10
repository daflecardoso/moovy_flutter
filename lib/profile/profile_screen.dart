import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moovy/gen/assets.gen.dart';
import 'package:moovy/l10n/app_localizations.dart';
import 'package:moovy/profile/profile_cubit.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

@RoutePage()
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileCubit cubit = ProfileCubit();

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(appLocalizations.profile, style: ShadTheme.of(context).textTheme.large)),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        bloc: cubit..start(),
        builder: (BuildContext context, ProfileState state) {
          return switch (state) {
            ProfileInitial() => const Center(child: Text('')),
            MustSignIn() => Padding(
              padding: EdgeInsetsGeometry.all(16),
              child: Column(
                spacing: 16,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ShadButton.outline(
                    leading: Assets.icon.google.image(width: 16),
                    child: Text(appLocalizations.googleSignIn),
                    onPressed: () {
                      cubit.signIn(.google);
                    },
                  ),
                  ShadButton(
                    leading: Icon(Icons.apple),
                    child: Text(appLocalizations.appleSignIn),
                    onPressed: () {
                      cubit.signIn(.apple);
                    },
                  ),
                ],
              ),
            ),
            ProfileUser() => Padding(
              padding: EdgeInsetsGeometry.all(16),
              child: Column(
                spacing: 16,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(child: Text(state.name ?? '-')),
                      switch (state.provider) {
                        null => SizedBox.shrink(),
                        SignInProvider.google => Assets.icon.google.image(width: 16),
                        SignInProvider.apple => Icon(Icons.apple),
                      },
                    ],
                  ),
                  ShadButton(
                    leading: Icon(Icons.exit_to_app),
                    child: Text(appLocalizations.signOut),
                    onPressed: () {
                      cubit.signOut();
                    },
                  ),
                ],
              ),
            ),
          };
        },
      ),
    );
  }
}
