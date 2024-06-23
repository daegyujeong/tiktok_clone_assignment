import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone_assignment/constants/gaps.dart';
import 'package:tiktok_clone_assignment/constants/sizes.dart';
import 'package:tiktok_clone_assignment/features/discover/discover_screen.dart';
import 'package:tiktok_clone_assignment/features/inbox/activity_screen.dart';
import 'package:tiktok_clone_assignment/features/main_navigation/widgets/nav_tab.dart';
// import 'package:tiktok_clone_assignment/features/inbox/inbox_screen.dart';
// import 'package:tiktok_clone_assignment/features/main_navigation/widgets/nav_tab.dart';
import 'package:tiktok_clone_assignment/features/main_navigation/widgets/post_video_button.dart';
import 'package:tiktok_clone_assignment/features/users/user_profile_screen.dart';
import 'package:tiktok_clone_assignment/features/videos/views/video_recording_screen.dart';
import 'package:tiktok_clone_assignment/features/writes/write_screen.dart';
import 'package:tiktok_clone_assignment/features/post/post_main.dart';
// import 'package:tiktok_clone_assignment/features/videos/video_timeline_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 1;

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onWriteTap() {
    showModalBottomSheet(
      // backgroundColor: Colors.white,
      context: context,
      builder: (context) => const WriteScreen(),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.9,
      ),
      isScrollControlled: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // backgroundColor: Colors.white,
      body: Stack(
        children: [
          Offstage(
            offstage: _selectedIndex != 0,
            child: const PostMain(),
          ),
          Offstage(
            offstage: _selectedIndex != 1,
            child: DiscoverScreen(),
          ),
          // Offstage(
          //   offstage: _selectedIndex != 2,
          //   child: const VideoRecordingScreen(),
          // ),
          Offstage(
            offstage: _selectedIndex != 3,
            child: const ActivityScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 4,
            child: const UserProfileScreen(),
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        // color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(Sizes.size12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NavTab(
                text: "Home",
                isSelected: _selectedIndex == 0,
                icon: FontAwesomeIcons.house,
                selectedIcon: FontAwesomeIcons.house,
                onTap: () => _onTap(0),
                selectedIndex: _selectedIndex,
              ),
              NavTab(
                text: "Discover",
                isSelected: _selectedIndex == 1,
                icon: FontAwesomeIcons.compass,
                selectedIcon: FontAwesomeIcons.solidCompass,
                onTap: () => _onTap(1),
                selectedIndex: _selectedIndex,
              ),
              NavTab(
                text: "Write",
                isSelected: _selectedIndex == 2,
                icon: FontAwesomeIcons.penToSquare,
                selectedIcon: FontAwesomeIcons.solidPenToSquare,
                onTap: _onWriteTap,
                selectedIndex: _selectedIndex,
              ),
              NavTab(
                text: "Like",
                isSelected: _selectedIndex == 3,
                icon: FontAwesomeIcons.heart,
                selectedIcon: FontAwesomeIcons.solidHeart,
                onTap: () => _onTap(3), //_onWriteTap,
                selectedIndex: _selectedIndex,
              ),
              NavTab(
                text: "Profile",
                isSelected: _selectedIndex == 4,
                icon: FontAwesomeIcons.user,
                selectedIcon: FontAwesomeIcons.solidUser,
                onTap: () => _onTap(4),
                selectedIndex: _selectedIndex,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
