import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone_assignment/constants/sizes.dart';
import 'package:tiktok_clone_assignment/constants/gaps.dart';

class ActionIconsRow extends StatelessWidget {
  final double iconSize;

  const ActionIconsRow({super.key, required this.iconSize});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: FaIcon(
            FontAwesomeIcons.heart,
            size: iconSize,
            // color: Colors.black,
          ),
          onPressed: () {},
        ),
        Gaps.h5,
        IconButton(
          icon: FaIcon(
            FontAwesomeIcons.comment,
            size: iconSize,
            // color: Colors.black,
          ),
          onPressed: () {},
        ),
        Gaps.h5,
        IconButton(
          icon: FaIcon(
            FontAwesomeIcons.retweet,
            size: iconSize,
            // color: Colors.black,
          ),
          onPressed: () {},
        ),
        Gaps.h5,
        IconButton(
          icon: FaIcon(
            FontAwesomeIcons.paperPlane,
            size: iconSize,
            // color: Colors.black,
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}
