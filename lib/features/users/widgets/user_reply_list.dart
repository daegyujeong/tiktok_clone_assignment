import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone_assignment/constants/gaps.dart';
import 'package:tiktok_clone_assignment/constants/sizes.dart';
import 'package:tiktok_clone_assignment/features/users/widgets/action_icon_row.dart';

class UserReplyList extends StatelessWidget {
  final String username;
  final String avatarUrl;
  final String timeAgo;
  final String content;
  final Map<String, String>? replyContent;
  final List<Map<String, String>> replies;

  const UserReplyList({
    required this.username,
    required this.avatarUrl,
    required this.timeAgo,
    required this.content,
    this.replyContent,
    required this.replies,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(avatarUrl),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      username,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: Sizes.size16,
                      ),
                    ),
                    Text(
                      timeAgo,
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: Sizes.size14,
                      ),
                    ),
                  ],
                ),
                Text(
                  content,
                  style: const TextStyle(
                    fontSize: Sizes.size14,
                  ),
                ),
                if (replyContent != null) ...[
                  Gaps.v10,
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          replyContent!['username']!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Sizes.size14,
                          ),
                        ),
                        Text(
                          replyContent!['content']!,
                          style: const TextStyle(
                            fontSize: Sizes.size14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                Gaps.v10,
                const ActionIconsRow(iconSize: Sizes.size20)
              ],
            ),
            contentPadding: EdgeInsets.zero,
          ),
          const Divider(),
          // Replies
          Column(
            children: replies.map((reply) {
              return ListTile(
                leading: CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(reply['avatarUrl']!),
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          reply['username']!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Sizes.size14,
                          ),
                        ),
                        Text(
                          reply['timeAgo']!,
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: Sizes.size12,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      reply['content']!,
                      style: const TextStyle(
                        fontSize: Sizes.size14,
                      ),
                    ),
                    Gaps.v10,
                    const ActionIconsRow(iconSize: Sizes.size20)
                  ],
                ),
                contentPadding: EdgeInsets.zero,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
