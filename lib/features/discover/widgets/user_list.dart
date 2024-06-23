import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone_assignment/constants/gaps.dart';
import 'package:tiktok_clone_assignment/constants/sizes.dart';

// Enum for user status
enum UserStatus {
  publicStoryUpload,
  closedFriendStoryUpload,
  none,
}

class UserList extends StatelessWidget {
  final UserStatus status;
  final String name;
  final String nickname;
  final String image;
  final String followerCount;
  final bool isFollowed;
  final bool hasBlueBadge;

  const UserList({
    super.key,
    this.status = UserStatus.none,
    this.name = 'default name',
    this.nickname = 'default nickname',
    this.image = 'assets/1.jpeg',
    this.followerCount = '0',
    this.isFollowed = false,
    this.hasBlueBadge = false,
  });

  @override
  Widget build(BuildContext context) {
    Color? borderColor;
    if (status == UserStatus.publicStoryUpload) {
      borderColor = Colors.blue;
    } else if (status == UserStatus.closedFriendStoryUpload) {
      borderColor = Colors.green;
    }

    return ListTile(
      leading: Container(
        width: Sizes.size52,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: borderColor != null
              ? Border.all(color: borderColor, width: 3)
              : null,
        ),
        child: Center(
          child: CircleAvatar(
            backgroundImage: AssetImage(image),
            radius: 20,
          ),
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: Sizes.size16,
                ),
              ),
              if (hasBlueBadge) ...[
                Gaps.h4,
                const FaIcon(
                  FontAwesomeIcons.circleCheck,
                  size: Sizes.size14,
                  color: Colors.blue,
                ),
              ],
            ],
          ),
          Opacity(
            opacity: 0.6,
            child: Text(
              nickname,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: Sizes.size14,
                // color: Colors.black38,
              ),
            ),
          ),
          Gaps.h10,
        ],
      ),
      subtitle: Text(
        '$followerCount followers',
        style: const TextStyle(
          fontSize: Sizes.size14,
        ),
      ),
      trailing: isFollowed
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
                'Following',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  // color: Colors.black,
                ),
              ),
            )
          : Container(
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
            ),
    );
  }
}
