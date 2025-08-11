# Profile Feature

This directory contains the profile management feature for the expenses app.

## Files

- **`profile_state.dart`** - Defines the state classes for the profile feature
- **`profile_cubit.dart`** - Business logic and state management for the profile
- **`profile_screen.dart`** - UI implementation of the profile screen

## Features

### Profile Management
- Display user profile information (name, email, avatar)
- Edit profile details (name, email)
- Update profile preferences

### Preferences
- Currency selection (USD, EUR, GBP)
- Theme selection (Light, Dark, System)
- Notification settings

### State Management
- Uses BLoC pattern with Cubit
- Handles loading, success, and error states
- Simulates API calls with delayed responses

## Usage

### Navigation
To navigate to the profile screen from another screen:

```dart
import 'package:expenses/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';

// Navigate to profile
context.router.push(const ProfileRoute());
```

### State Handling
The profile cubit provides several methods:

```dart
final profileCubit = ProfileCubit();

// Load profile data
profileCubit.loadProfile();

// Update profile information
profileCubit.updateProfile(
  name: 'New Name',
  email: 'new@email.com',
);

// Update specific preferences
profileCubit.updatePreference('currency', 'EUR');
```

## Architecture

The profile feature follows the same architecture pattern as the expenses feature:

1. **State** - Immutable state classes using sealed classes
2. **Cubit** - Business logic and state management
3. **Screen** - UI implementation with BLoC integration

## Dependencies

- `flutter_bloc` - State management
- `auto_route` - Navigation
- `shadcn_ui` - UI components
