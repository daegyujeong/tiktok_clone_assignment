import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiktok_clone_assignment/features/settings/models/setting_model.dart';
import 'package:tiktok_clone_assignment/features/settings/privacy_screen.dart';
import 'package:tiktok_clone_assignment/features/settings/repos/setting_repo.dart';
import 'package:tiktok_clone_assignment/features/settings/view_models/setting_view_model.dart';

// final settingRepositoryProvider = Provider<SettingRepository>((ref) {
//   final sharedPreferences = ref.watch(sharedPreferencesProvider);
//   return SettingRepository(sharedPreferences);
// });

// final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
//   throw UnimplementedError();
// });

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  final bool _isLoading = false;

  void _navigateToPrivacyScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const PrivacyScreen(),
      ),
    );
  }

  // void _showLogoutDialog(BuildContext context) {
  //   setState(() {
  //     _isLoading = true;
  //   });
  //   // Simulate a delay to show the loading animation
  //   Future.delayed(const Duration(seconds: 2), () {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //     showCupertinoDialog(
  //       context: context,
  //       builder: (context) => CupertinoAlertDialog(
  //         title: const Text('Log Out'),
  //         content: const Text('Are you sure you want to log out?'),
  //         actions: [
  //           CupertinoDialogAction(
  //             child: const Text('Cancel'),
  //             onPressed: () => Navigator.of(context).pop(),
  //           ),
  //           CupertinoDialogAction(
  //             isDestructiveAction: true,
  //             child: const Text('Log Out'),
  //             onPressed: () {
  //               // Handle log out action
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       ),
  //     );
  //   });
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final settingViewModel = ref.watch(settingProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.person_add),
            title: const Text('Follow and invite friends'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notifications'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.lock),
            title: const Text('Privacy'),
            onTap: () => _navigateToPrivacyScreen(context),
          ),
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text('Account'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('Help'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.brightness_6),
            title: const Text('Dark Mode'),
            trailing: DropdownButton<DarkMode>(
              value: ref.watch(settingConfigProvider).darkmode,
              onChanged: (DarkMode? newValue) {
                if (newValue != null) {
                  ref
                      .read(settingConfigProvider.notifier)
                      .setDarkMode(newValue);
                  // settingViewModel.setDarkMode(newValue);
                }
              },
              items: DarkMode.values.map((DarkMode mode) {
                return DropdownMenuItem<DarkMode>(
                  value: mode,
                  child: Text(mode.toString().split('.').last),
                );
              }).toList(),
            ),
          ),
          ListTile(
            title: Row(
              children: [
                const Text(
                  'Log out',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                const Spacer(),
                if (_isLoading) const CupertinoActivityIndicator(),
              ],
            ),
            // onTap: () => _showLogoutDialog(context),
          ),
        ],
      ),
    );
  }
}
