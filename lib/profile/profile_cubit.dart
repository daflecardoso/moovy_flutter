import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  void start() {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      emit(MustSignIn());
    } else {
      emit(ProfileUser(name: user.email));
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
    emit(ProfileUser(name: credentials.user?.email));
  }

  void signOut() async {
    await FirebaseAuth.instance.signOut();
    emit(MustSignIn());
  }
}
