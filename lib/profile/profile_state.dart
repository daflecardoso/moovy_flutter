part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class MustSignIn extends ProfileState {}

final class ProfileUser extends ProfileState {
  final String? name;
  final SignInProvider? provider;

  ProfileUser({ required this.name, required this.provider });
}

enum SignInProvider {
  google, apple;

  static SignInProvider? fromId(String? id) {
    return switch(id) {
      'apple.com' => .apple,
      'google.com' => .google,
      _ => null
    };
  }
}
