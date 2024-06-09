import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone_assignment/constants/gaps.dart';
import 'package:tiktok_clone_assignment/constants/sizes.dart';
import 'package:tiktok_clone_assignment/features/onboarding/widgets/interest_button_v2.dart';

const interests = [
  "Daily Life",
  "Comedy",
  "Entertainment",
  "Animals",
  "Food",
  "Beauty & Style",
  "Drama",
  "Learning",
  "Talent",
  "Sports",
  "Auto",
  "Family",
  "Fitness & Health",
  "DIY & Life Hacks",
  "Arts & Crafts",
  "Dance",
  "Outdoors",
  "Oddly Satisfying",
  "Home & Garden",
  "Daily Life",
  "Comedy",
  "Entertainment",
  "Animals",
  "Food",
  "Beauty & Style",
  "Drama",
  "Learning",
  "Talent",
  "Sports",
  "Auto",
  "Family",
  "Fitness & Health",
  "DIY & Life Hacks",
  "Arts & Crafts",
  "Dance",
  "Outdoors",
  "Oddly Satisfying",
  "Home & Garden",
];

class InterestsScreenV2 extends StatefulWidget {
  const InterestsScreenV2({super.key, required this.selectedInterests});
  final List<String> selectedInterests;
  @override
  State<InterestsScreenV2> createState() => _InterestsScreenV2State();
}

class _InterestsScreenV2State extends State<InterestsScreenV2> {
  final ScrollController _verticalScrollController = ScrollController();
  final List<ScrollController> _horizontalScrollControllers = [];
  final Set<String> _selectedDetailInterests = {};

  bool _showTitle = false;

  @override
  void initState() {
    super.initState();
    _verticalScrollController.addListener(_onScroll);
    _initializeHorizontalScrollControllers();
  }

  void _initializeHorizontalScrollControllers() {
    for (int i = 0; i < widget.selectedInterests.length; i++) {
      _horizontalScrollControllers.add(ScrollController());
    }
  }

  @override
  void dispose() {
    _verticalScrollController.dispose();
    for (var controller in _horizontalScrollControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _onScroll() {
    if (_verticalScrollController.offset > 100) {
      if (_showTitle) return;
      setState(() {
        _showTitle = true;
      });
    } else {
      setState(() {
        _showTitle = false;
      });
    }
  }

  void _toggleInterest(String interest) {
    setState(() {
      if (_selectedDetailInterests.contains(interest)) {
        _selectedDetailInterests.remove(interest);
      } else {
        _selectedDetailInterests.add(interest);
      }
    });
  }

  void _onNextTap() {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => const TutorialScreen(),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    // Divide the interests into three rows
    final int itemsPerRow = (interests.length / 3).ceil();
    final List<String> row1 = interests.sublist(0, itemsPerRow);
    final List<String> row2 = interests.sublist(itemsPerRow, itemsPerRow * 2);
    final List<String> row3 = interests.sublist(itemsPerRow * 2);

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
            Gaps.v40,
            const Text(
              "What do you want to see on Twitter?",
              style: TextStyle(
                fontSize: Sizes.size24,
                fontWeight: FontWeight.w900,
              ),
            ),
            Gaps.v14,
            const Text(
              "Interests are used to personalize your experience and will be visible on your profile.",
              style: TextStyle(
                fontSize: Sizes.size16,
                color: Colors.black54,
              ),
            ),
            Gaps.v20,
            Expanded(
              child: Scrollbar(
                controller: _verticalScrollController,
                child: SingleChildScrollView(
                  controller: _verticalScrollController,
                  child: Column(
                    children: [
                      for (int i = 0; i < widget.selectedInterests.length; i++)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Gaps.v14,
                            Text(
                              widget.selectedInterests[i],
                              style: const TextStyle(
                                fontSize: Sizes.size20,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            Gaps.v14,
                            Scrollbar(
                              controller: _horizontalScrollControllers[i],
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                controller: _horizontalScrollControllers[i],
                                child: Column(
                                  children: [
                                    Wrap(
                                      runSpacing: 15,
                                      spacing: 15,
                                      children: [
                                        for (var interest in row1)
                                          InterestButtonV2(
                                            interest: interest,
                                            isSelected: _selectedDetailInterests
                                                .contains(interest),
                                            onTap: () =>
                                                _toggleInterest(interest),
                                          ),
                                      ],
                                    ),
                                    Gaps.v20,
                                    Wrap(
                                      runSpacing: 15,
                                      spacing: 15,
                                      children: [
                                        for (var interest in row2)
                                          InterestButtonV2(
                                            interest: interest,
                                            isSelected: _selectedDetailInterests
                                                .contains(interest),
                                            onTap: () =>
                                                _toggleInterest(interest),
                                          ),
                                      ],
                                    ),
                                    Gaps.v20,
                                    Wrap(
                                      runSpacing: 15,
                                      spacing: 15,
                                      children: [
                                        for (var interest in row3)
                                          InterestButtonV2(
                                            interest: interest,
                                            isSelected: _selectedDetailInterests
                                                .contains(interest),
                                            onTap: () =>
                                                _toggleInterest(interest),
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ),
            Gaps.v20,
            const Text(
              "Selected Interests:",
              style: TextStyle(
                fontSize: Sizes.size20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Wrap(
              spacing: 10,
              children: widget.selectedInterests
                  .map((interest) => Chip(
                        label: Text(interest),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.only(
            bottom: Sizes.size40,
            top: Sizes.size16,
            left: Sizes.size24,
            right: Sizes.size24,
          ),
          child: GestureDetector(
            onTap: _selectedDetailInterests.length >= 3 ? _onNextTap : null,
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: Sizes.size16 + Sizes.size2,
              ),
              decoration: BoxDecoration(
                color: _selectedDetailInterests.length >= 3
                    ? Theme.of(context).primaryColor
                    : Colors.grey,
                borderRadius: BorderRadius.circular(Sizes.size24),
              ),
              child: const Text(
                'Next',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: Sizes.size16,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
