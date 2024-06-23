import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone_assignment/constants/sizes.dart';

class PersistentTabBar extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height:
          47, // Ensure the container height is the same as maxExtent and minExtent
      decoration: BoxDecoration(
        // color: Colors.white,
        border: Border.symmetric(
          horizontal: BorderSide(
            color: Colors.grey.shade200,
            width: 0.5,
          ),
        ),
      ),
      child: const TabBar(
        indicatorSize: TabBarIndicatorSize.label,
        // indicatorColor: Colors.black,
        labelPadding: EdgeInsets.symmetric(
          vertical: Sizes.size10,
        ),
        // labelColor: Colors.black,
        unselectedLabelColor: Colors.grey,
        tabs: [
          Text(
            "Threads",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: Sizes.size16,
            ),
          ),
          Text(
            "Replies",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: Sizes.size16,
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 47;

  @override
  double get minExtent => 47;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
