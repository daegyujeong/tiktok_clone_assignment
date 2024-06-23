import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone_assignment/constants/gaps.dart';
import 'package:tiktok_clone_assignment/constants/sizes.dart';
import 'package:tiktok_clone_assignment/features/inbox/widgets/activity_list.dart';
import 'package:tiktok_clone_assignment/utils.dart';

final tabs = [
  "All",
  "Replies",
  "Mentions",
  "Videos",
];

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: false,
          title: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Activity',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: Sizes.size36,
                ),
              ),
            ],
          ),
          // elevation: 1,
          bottom: TabBar(
            controller: _tabController,
            splashFactory: NoSplash.splashFactory,
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size8,
            ),
            isScrollable: true,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: Sizes.size16,
            ),
            indicatorColor: Colors.transparent,
            // labelColor: Colors.black,
            // unselectedLabelColor: Colors.black,
            tabs: [
              for (var i = 0; i < tabs.length; i++)
                Tab(
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 4.0), // Adjusts the gap between the tabs
                    width: 100,
                    height: 40,
                    padding: const EdgeInsets.symmetric(
                      horizontal: Sizes.size8,
                      vertical: Sizes.size4,
                    ),
                    decoration: BoxDecoration(
                      color: _tabController.index == i
                          ? isDarkMode(context)
                              ? Colors.grey
                              : Colors.black
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        // color: Colors.black,
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        tabs[i],
                        style: TextStyle(
                          color: _tabController.index == i
                              ? Colors.white
                              : isDarkMode(context)
                                  ? Colors.grey
                                  : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        body: ListView(
          children: const [
            ActivityList(
              activityType: ActivityType.mention,
              username: 'john_mobbin',
              time: '4h',
              content:
                  "Here's a thread you should follow if you love botany @jane_mobbin",
            ),
            ActivityList(
              activityType: ActivityType.follow,
              username: 'the.plantdads',
              time: '5h',
              content: 'Followed you',
            ),
            ActivityList(
              activityType: ActivityType.comment,
              username: 'the.plantdads',
              time: '5h',
              content: 'Definitely broken! 🌱',
            ),
            ActivityList(
              activityType: ActivityType.like,
              username: 'theberryjungle',
              time: '5h',
              content: '🌱👀🧵',
            ),
          ],
        ),
      ),
    );
  }
}
