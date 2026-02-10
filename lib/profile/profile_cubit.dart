import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moovy/events/sign_in_sign_out.dart';
import 'package:moovy/main.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  void start() {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      emit(MustSignIn());
    } else {
      final providerId = user.providerData.firstOrNull?.providerId;
      emit(ProfileUser(name: user.email, provider: SignInProvider.fromId(providerId)));
    }
  }

  void signIn(SignInProvider provider) async {
    final credentials = await FirebaseAuth.instance.signInWithProvider(switch (provider) {
      SignInProvider.apple =>
        AppleAuthProvider()
          ..addScope('email')
          ..addScope('name'),
      SignInProvider.google => GoogleAuthProvider(),
      // ..addScope('email')
      // ..addScope('name'),
    });
    emit(ProfileUser(name: credentials.user?.email, provider: provider));
    eventBus.fire(SignInSignOut());
  }

  void signOut() async {
    await FirebaseAuth.instance.signOut();
    emit(MustSignIn());
    eventBus.fire(SignInSignOut());
  }
}
