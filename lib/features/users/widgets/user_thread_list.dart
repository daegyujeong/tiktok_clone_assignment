import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone_assignment/constants/gaps.dart';
import 'package:tiktok_clone_assignment/constants/sizes.dart';
import 'package:tiktok_clone_assignment/features/users/widgets/action_icon_row.dart';
import 'package:tiktok_clone_assignment/utils.dart';

class UserThreadList extends StatelessWidget {
  final String username;
  final String avatarUrl;
  final String timeAgo;
  final String content;
  final String? imageUrl;

  const UserThreadList({
    required this.username,
    required this.avatarUrl,
    required this.timeAgo,
    required this.content,
    this.imageUrl,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ListTile(
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
                  style: TextStyle(
                    color: isDarkMode(context) ? null : Colors.black54,
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
            if (imageUrl != null) ...[
              Gaps.v10,
              Image.network(imageUrl!),
            ],
            Gaps.v10,
            const ActionIconsRow(iconSize: Sizes.size20)
          ],
        ),
        contentPadding: EdgeInsets.zero,
        subtitle: const Divider(),
      ),
    );
  }
}
