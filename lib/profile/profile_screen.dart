import 'package:auto_route/annotations.dart';
import 'package:moovy/profile/profile_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

@RoutePage()
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final ProfileCubit _profileCubit;

  @override
  void initState() {
    super.initState();
    _profileCubit = ProfileCubit();
    _profileCubit.loadProfile();
  }

  @override
  void dispose() {
    _profileCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile'), backgroundColor: Theme.of(context).colorScheme.inversePrimary),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        bloc: _profileCubit,
        builder: (BuildContext context, ProfileState state) {
          return switch (state) {
            ProfileInitial() => const Center(child: Text('Initializing profile...')),
            ProfileLoading() => const Center(child: CircularProgressIndicator()),
            ProfileLoaded() => _buildProfileContent(state),
            ProfileError() => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${state.message}'),
                  const SizedBox(height: 16),
                  ShadButton(onPressed: () => _profileCubit.loadProfile(), child: const Text('Retry')),
                ],
              ),
            ),
          };
        },
      ),
    );
  }

  Widget _buildProfileContent(ProfileLoaded state) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Header
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: state.avatarUrl != null
                      ? ClipOval(
                          child: Image.network(
                            state.avatarUrl!,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => _buildDefaultAvatar(state.name),
                          ),
                        )
                      : _buildDefaultAvatar(state.name),
                ),
                const SizedBox(height: 16),
                Text(state.name, style: Theme.of(context).textTheme.headlineSmall),
                Text(
                  state.email,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // Profile Actions
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Actions', style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ShadButton(
                          onPressed: () => _showEditProfileDialog(state),
                          child: const Text('Edit Profile'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ShadButton(
                          onPressed: () => _showPreferencesDialog(state),
                          child: const Text('Preferences'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Preferences
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Preferences', style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 16),
                  _buildPreferenceItem('Currency', state.preferences['currency'] ?? 'Not set'),
                  _buildPreferenceItem('Theme', state.preferences['theme'] ?? 'Not set'),
                  _buildPreferenceItem(
                    'Notifications',
                    state.preferences['notifications'] == true ? 'Enabled' : 'Disabled',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDefaultAvatar(String name) {
    return Text(
      name.isNotEmpty ? name[0].toUpperCase() : '?',
      style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
    );
  }

  Widget _buildPreferenceItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(value, style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant)),
        ],
      ),
    );
  }

  void _showEditProfileDialog(ProfileLoaded state) {
    final nameController = TextEditingController(text: state.name);
    final emailController = TextEditingController(text: state.email);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Profile'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder()),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancel')),
          ShadButton(
            onPressed: () {
              _profileCubit.updateProfile(name: nameController.text, email: emailController.text);
              Navigator.of(context).pop();
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showPreferencesDialog(ProfileLoaded state) {
    String selectedCurrency = state.preferences['currency'] ?? 'USD';
    String selectedTheme = state.preferences['theme'] ?? 'light';
    bool notifications = state.preferences['notifications'] ?? true;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Preferences'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                value: selectedCurrency,
                decoration: const InputDecoration(labelText: 'Currency', border: OutlineInputBorder()),
                items: const [
                  DropdownMenuItem(value: 'USD', child: Text('USD')),
                  DropdownMenuItem(value: 'EUR', child: Text('EUR')),
                  DropdownMenuItem(value: 'GBP', child: Text('GBP')),
                ],
                onChanged: (value) {
                  setState(() {
                    selectedCurrency = value!;
                  });
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: selectedTheme,
                decoration: const InputDecoration(labelText: 'Theme', border: OutlineInputBorder()),
                items: const [
                  DropdownMenuItem(value: 'light', child: Text('Light')),
                  DropdownMenuItem(value: 'dark', child: Text('Dark')),
                  DropdownMenuItem(value: 'system', child: Text('System')),
                ],
                onChanged: (value) {
                  setState(() {
                    selectedTheme = value!;
                  });
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Checkbox(
                    value: notifications,
                    onChanged: (value) {
                      setState(() {
                        notifications = value!;
                      });
                    },
                  ),
                  const Text('Enable Notifications'),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancel')),
            ShadButton(
              onPressed: () {
                _profileCubit.updatePreference('currency', selectedCurrency);
                _profileCubit.updatePreference('theme', selectedTheme);
                _profileCubit.updatePreference('notifications', notifications);
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
