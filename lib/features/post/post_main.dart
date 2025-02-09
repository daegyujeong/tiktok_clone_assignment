import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone_assignment/constants/gaps.dart';
import 'package:tiktok_clone_assignment/constants/sizes.dart';
import 'package:tiktok_clone_assignment/features/post/widgets/postitem.dart';
import 'package:tiktok_clone_assignment/features/post/widgets/postitem2.dart';

class PostMain extends StatefulWidget {
  const PostMain({super.key});
  @override
  State<PostMain> createState() => _PostMainState();
}

class _PostMainState extends State<PostMain> {
  final ScrollController _verticalScrollController = ScrollController();
  final List<ScrollController> _horizontalScrollControllers = [];
  final Set<String> _selectedDetailInterests = {};
  final bool _showTitle = false;
  int _selectedIndex = 0;

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    // _initializeHorizontalScrollControllers();
  }

  @override
  void dispose() {
    _verticalScrollController.dispose();
    for (var controller in _horizontalScrollControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const FaIcon(
          FontAwesomeIcons.twitter,
          color: Colors.blue,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: Sizes.size24,
          right: Sizes.size24,
          bottom: Sizes.size16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Scrollbar(
                controller: _verticalScrollController,
                child: SingleChildScrollView(
                  controller: _verticalScrollController,
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PostItem(),
                      PostItem(),
                      PostItem(),
                      PostItem(),
                      PostItemWithPhotos(),
                    ],
                  ),
                ),
              ),
            ),
            Gaps.v20,
          ],
        ),
      ),
    );
  }
}
