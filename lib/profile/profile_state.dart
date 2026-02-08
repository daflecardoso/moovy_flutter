part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class MustSignIn extends ProfileState {}

final class ProfileUser extends ProfileState {
  final String? name;

  ProfileUser({ required this.name });
}

enum SignInProvider {
  google, apple
}
