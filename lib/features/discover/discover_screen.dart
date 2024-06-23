import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone_assignment/constants/gaps.dart';
import 'package:tiktok_clone_assignment/constants/sizes.dart';
import 'package:tiktok_clone_assignment/features/discover/widgets/user_list.dart';
import 'package:tiktok_clone_assignment/features/inbox/activity_screen.dart';

class DiscoverScreen extends StatelessWidget {
  DiscoverScreen({super.key});

  void _onDmPressed() {}

  final TextEditingController textEditingController = TextEditingController();

  void onSearchChanged(String value) {
    print("Searching form $value");
  }

  void onSearchSubmitted(String value) {
    print("Submitted $value");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // elevation: 1,
        centerTitle: false,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Search',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: Sizes.size36,
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            title: CupertinoSearchTextField(
              controller: textEditingController,
              onChanged: onSearchChanged,
              onSubmitted: onSearchSubmitted,
            ),
          ),
          const UserList(
            status: UserStatus.closedFriendStoryUpload,
          ),
          const UserList(
            status: UserStatus.publicStoryUpload,
            name: 'John Doe',
            nickname: 'johndoe',
            isFollowed: true,
            followerCount: '100',
          ),
          const UserList(
            status: UserStatus.none,
            name: 'John',
            nickname: 'john2',
            isFollowed: true,
            followerCount: '100',
            image: 'assets/2.jpeg',
          ),
          const UserList(
            status: UserStatus.closedFriendStoryUpload,
          ),
          const UserList(
            status: UserStatus.closedFriendStoryUpload,
          ),
        ],
      ),
    );
  }
}
