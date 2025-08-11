part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileLoaded extends ProfileState {
  final String name;
  final String email;
  final String? avatarUrl;
  final Map<String, dynamic> preferences;

  ProfileLoaded({
    required this.name,
    required this.email,
    this.avatarUrl,
    this.preferences = const {},
  });
}

final class ProfileError extends ProfileState {
  final String message;

  ProfileError(this.message);
}
