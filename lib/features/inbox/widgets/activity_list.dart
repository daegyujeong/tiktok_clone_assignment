import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone_assignment/constants/gaps.dart';
import 'package:tiktok_clone_assignment/constants/sizes.dart';
import 'package:tiktok_clone_assignment/utils.dart';

// Enum for activity type
enum ActivityType {
  mention,
  follow,
  comment,
  like,
  none,
}

class ActivityList extends StatelessWidget {
  final ActivityType activityType;
  final String username;
  final String time;
  final String content;

  const ActivityList({
    super.key,
    required this.activityType,
    required this.username,
    required this.time,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    IconData? icon;
    Color? iconColor;

    switch (activityType) {
      case ActivityType.mention:
        icon = FontAwesomeIcons.at;
        iconColor = Colors.green;
        break;
      case ActivityType.follow:
        icon = FontAwesomeIcons.userPlus;
        iconColor = Colors.blue;
        break;
      case ActivityType.comment:
        icon = FontAwesomeIcons.comment;
        iconColor = Colors.purple;
        break;
      case ActivityType.like:
        icon = FontAwesomeIcons.heart;
        iconColor = Colors.red;
        break;
      case ActivityType.none:
      default:
        icon = null;
        iconColor = null;
        break;
    }

    return ListTile(
      leading: CircleAvatar(
        backgroundImage: const AssetImage('assets/1.jpeg'),
        radius: 20,
        child: icon != null
            ? Align(
                alignment: Alignment.bottomRight,
                child: FaIcon(
                  icon,
                  color: iconColor,
                  size: Sizes.size16,
                ),
              )
            : null,
      ),
      title: Row(
        children: [
          Text(
            username,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: Sizes.size16,
            ),
          ),
          Gaps.h4,
          Text(
            time,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: Sizes.size14,
              color: isDarkMode(context) ? null : Colors.black38,
            ),
          ),
        ],
      ),
      subtitle: Text(
        content,
        style: const TextStyle(
          fontSize: Sizes.size14,
          // color: Colors.black,
        ),
      ),
      trailing: activityType == ActivityType.follow
          ? Container(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size20,
                vertical: Sizes.size8,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Text(
                'Follow',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  // color: Colors.black,
                ),
              ),
            )
          : null,
    );
  }
}
