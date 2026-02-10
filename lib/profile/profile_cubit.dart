import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moovy/events/sign_in_sign_out.dart';
import 'package:moovy/main.dart';
import 'package:package_info_plus/package_info_plus.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  void start() {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      emit(MustSignIn());
    } else {
      _emitUser(user);
    }
  }

  void signIn(SignInProvider provider) async {
    final credentials = await FirebaseAuth.instance.signInWithProvider(switch (provider) {
      SignInProvider.apple =>
        AppleAuthProvider()
          ..addScope('email')
          ..addScope('name'),
      SignInProvider.google => GoogleAuthProvider(),
    });
    await _emitUser(credentials.user);
    eventBus.fire(SignInSignOut());
  }

  Future<void> _emitUser(User? user) async {
    final providerId = user?.providerData.firstOrNull?.providerId;
    final provider = SignInProvider.fromId(providerId);
    emit(ProfileUser(name: user?.email, appVersion: await _appVersion(), provider: provider));
  }

  Future<String> _appVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;
    return 'v $version ($buildNumber)';
  }

  void signOut() async {
    await FirebaseAuth.instance.signOut();
    emit(MustSignIn());
    eventBus.fire(SignInSignOut());
  }
}
