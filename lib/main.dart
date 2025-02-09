import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiktok_clone_assignment/constants/sizes.dart';
import 'package:tiktok_clone_assignment/features/account/sign_in_screen.dart';
import 'package:tiktok_clone_assignment/features/authentication/verification_screen.dart';
import 'package:tiktok_clone_assignment/features/main_navigation/main_navigation.dart';
import 'package:tiktok_clone_assignment/features/onboarding/interests_screen.dart';
import 'package:tiktok_clone_assignment/features/onboarding/interests_screen_v2.dart';
import 'package:tiktok_clone_assignment/features/settings/models/setting_model.dart';
import 'package:tiktok_clone_assignment/features/settings/repos/setting_repo.dart';
import 'package:tiktok_clone_assignment/features/settings/view_models/setting_view_model.dart';
import 'package:tiktok_clone_assignment/features/videos/repos/playback_config_repo.dart';
import 'package:tiktok_clone_assignment/features/videos/view_models/playback_config_vm.dart';
import 'package:tiktok_clone_assignment/firebase_options.dart';
import 'package:tiktok_clone_assignment/features/post/post_main.dart';
import 'package:tiktok_clone_assignment/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ],
  );

  final preferences = await SharedPreferences.getInstance();
  final preferences2 = await SharedPreferences.getInstance();
  final settingRepository = SettingRepository(preferences2);
  final repository = PlaybackConfigRepository(preferences);

  runApp(ProviderScope(
    overrides: [
      // sharedPreferencesProvider.overrideWithValue(preferences),
      settingConfigProvider
          .overrideWith(() => SettingViewModel(settingRepository)),
      // playbackConfigRepositoryProvider.overrideWithValue(repository),
    ],
    child: const TikTokApp(),
  ));
}

class TikTokApp extends ConsumerWidget {
  const TikTokApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final darkmode = ref.watch(settingConfigProvider).darkmode;
    ThemeMode themeMode;

    switch (darkmode) {
      case DarkMode.light:
        themeMode = ThemeMode.light;
        break;
      case DarkMode.dark:
        themeMode = ThemeMode.dark;
        break;
      case DarkMode.system:
      default:
        themeMode = ThemeMode.system;
        break;
    }

    return MaterialApp.router(
      routerConfig: ref.watch(routerProvider),
      title: 'TikTok Clone',
      themeMode: themeMode,
      theme: ThemeData(
        useMaterial3: false,
        scaffoldBackgroundColor: Colors.white,
        primaryColor: const Color(0xFF4A98E9),
        appBarTheme: const AppBarTheme(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: Sizes.size16 + Sizes.size2,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        bottomAppBarTheme: BottomAppBarTheme(
          color: Colors.grey.shade900,
        ),
        primaryColor: const Color(0xFFE9435A),
      ),
      // home:
      //     const MainNavigationScreen(), //SignInScreen(), //MainNavigationScreen() VerificationScreen(),
    );
  }
}
