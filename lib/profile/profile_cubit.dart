import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  void loadProfile() {
    emit(ProfileLoading());
    
    // Simulate loading profile data
    Future.delayed(const Duration(milliseconds: 500), () {
      emit(ProfileLoaded(
        name: 'John Doe',
        email: 'john.doe@example.com',
        avatarUrl: null,
        preferences: {
          'currency': 'USD',
          'theme': 'light',
          'notifications': true,
        },
      ));
    });
  }

  void updateProfile({
    String? name,
    String? email,
    String? avatarUrl,
    Map<String, dynamic>? preferences,
  }) {
    final currentState = state;
    if (currentState is ProfileLoaded) {
      emit(ProfileLoaded(
        name: name ?? currentState.name,
        email: email ?? currentState.email,
        avatarUrl: avatarUrl ?? currentState.avatarUrl,
        preferences: preferences ?? currentState.preferences,
      ));
    }
  }

  void updatePreference(String key, dynamic value) {
    final currentState = state;
    if (currentState is ProfileLoaded) {
      final updatedPreferences = Map<String, dynamic>.from(currentState.preferences);
      updatedPreferences[key] = value;
      emit(ProfileLoaded(
        name: currentState.name,
        email: currentState.email,
        avatarUrl: currentState.avatarUrl,
        preferences: updatedPreferences,
      ));
    }
  }
}
