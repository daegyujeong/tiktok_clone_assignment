import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone_assignment/constants/gaps.dart';
import 'package:tiktok_clone_assignment/constants/sizes.dart';
import 'package:tiktok_clone_assignment/features/settings/setting_screen.dart';
import 'package:tiktok_clone_assignment/features/users/widgets/persistent_tab_bar.dart';
import 'package:tiktok_clone_assignment/features/users/widgets/user_reply_list.dart';
import 'package:tiktok_clone_assignment/features/users/widgets/user_thread_list.dart';
import 'package:tiktok_clone_assignment/utils.dart';

// Sample data for different threads
final List<Map<String, String>> threadsData = [
  {
    "username": "jane_mobbin",
    "avatarUrl": "https://avatars.githubusercontent.com/u/3612017",
    "timeAgo": "5h",
    "content":
        "Give @john_mobbin a follow if you want to see more travel content!"
  },
  {
    "username": "jane_mobbin",
    "avatarUrl": "https://avatars.githubusercontent.com/u/3612017",
    "timeAgo": "6h",
    "content": "Tea. Spillage.",
    "imageUrl":
        "https://avatars.githubusercontent.com/u/3612017" // Add image URL if available
  },
  // Add more threads as needed
];

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: const FaIcon(
                      FontAwesomeIcons.globe,
                      size: Sizes.size20,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const FaIcon(
                      FontAwesomeIcons.instagram,
                      size: Sizes.size20,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const SettingsScreen()));
                    },
                    icon: const FaIcon(
                      FontAwesomeIcons.bars,
                      size: Sizes.size20,
                    ),
                  )
                ],
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Jane",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: Sizes.size24,
                                ),
                              ),
                              Gaps.v10,
                              Row(
                                children: [
                                  Text(
                                    "jane_mobbin",
                                    style: TextStyle(
                                      fontSize: Sizes.size16,
                                      color: isDarkMode(context)
                                          ? Colors.grey
                                          : Colors.black87,
                                    ),
                                  ),
                                  Gaps.h5,
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: Sizes.size6,
                                      vertical: Sizes.size4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isDarkMode(context)
                                          ? Colors.black12
                                          : Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(
                                        Sizes.size16,
                                      ),
                                    ),
                                    child: Text(
                                      "threads.net",
                                      style: TextStyle(
                                        fontSize: Sizes.size12,
                                        color: isDarkMode(context)
                                            ? null
                                            : Colors.black38,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const CircleAvatar(
                            radius: 40,
                            foregroundImage: NetworkImage(
                                "https://avatars.githubusercontent.com/u/3612017"),
                            child: Text("Jane"),
                          ),
                        ],
                      ),
                      Gaps.v10,
                      const Text(
                        "Plant enthusiast!",
                        style: TextStyle(
                          fontSize: Sizes.size16,
                        ),
                      ),
                      Gaps.v20,
                      Row(
                        children: [
                          const CircleAvatar(
                            radius: 10,
                            backgroundImage: AssetImage('assets/1.jpeg'),
                          ),
                          Gaps.h4,
                          Text(
                            "2 followers",
                            style: TextStyle(
                              fontSize: Sizes.size16,
                              color:
                                  isDarkMode(context) ? null : Colors.black54,
                            ),
                          ),
                        ],
                      ),
                      Gaps.v20,
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: Colors.grey.shade300),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(Sizes.size8),
                                ),
                              ),
                              child: const Text(
                                'Edit profile',
                                style: TextStyle(
                                  // color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Gaps.h10,
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: Colors.grey.shade300),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(Sizes.size8),
                                ),
                              ),
                              child: const Text(
                                'Share profile',
                                style: TextStyle(
                                  // color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Gaps.v10,
                    ],
                  ),
                ),
              ),
              SliverPersistentHeader(
                delegate: PersistentTabBar(),
                pinned: true,
              ),
            ];
          },
          body: TabBarView(
            children: [
              ListView.builder(
                itemCount: threadsData.length,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  final thread = threadsData[index];
                  return UserThreadList(
                    username: thread['username']!,
                    avatarUrl: thread['avatarUrl']!,
                    timeAgo: thread['timeAgo']!,
                    content: thread['content']!,
                    imageUrl: thread['imageUrl'],
                  );
                },
              ),
              ListView.builder(
                itemCount: 5,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) => const UserReplyList(
                  username: 'john_mobbin',
                  avatarUrl: 'https://avatars.githubusercontent.com/u/3612017',
                  timeAgo: '5h',
                  content: "Always a dream to see the Medina in Morocco!",
                  replyContent: {
                    'username': 'earthpix',
                    'content':
                        "What is one place you’re absolutely traveling to by next year?",
                  },
                  replies: [
                    {
                      'username': 'jane_mobbin',
                      'avatarUrl':
                          'https://avatars.githubusercontent.com/u/3612017',
                      'timeAgo': '5h',
                      'content': "See you there!",
                    },
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
