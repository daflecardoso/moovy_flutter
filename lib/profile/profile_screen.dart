import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        bloc: cubit,
        builder: (BuildContext context, ProfileState state) {
          return switch (state) {
            ProfileInitial() => const Center(child: Text('soon...')),
          };
        },
      ),
    );
  }
}
