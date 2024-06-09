import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone_assignment/constants/gaps.dart';
import 'package:tiktok_clone_assignment/constants/sizes.dart';
import 'package:tiktok_clone_assignment/features/onboarding/interests_screen_v2.dart';
import 'package:tiktok_clone_assignment/features/onboarding/widgets/interest_button.dart';

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
];

class InterestsScreen extends StatefulWidget {
  const InterestsScreen({super.key});

  @override
  State<InterestsScreen> createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreen> {
  final ScrollController _scrollController = ScrollController();
  final Set<String> _selectedInterests = {};
  final List<String> _selectionOrder = [];

  bool _showTitle = false;

  void _onScroll() {
    if (_scrollController.offset > 100) {
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

  void _onNextTap() {
    List<String> selectedInterests = _selectedInterests.toList();
    if (_selectedInterests.length >= 3) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => InterestsScreenV2(
            selectedInterests: selectedInterests,
          ),
        ),
      );
    }
  }

  void _toggleInterest(String interest) {
    setState(() {
      if (_selectedInterests.contains(interest)) {
        _selectedInterests.remove(interest);
        _selectionOrder.remove(interest);
      } else {
        if (_selectedInterests.length >= 3) {
          final firstSelected = _selectionOrder.removeAt(0);
          _selectedInterests.remove(firstSelected);
        }
        _selectedInterests.add(interest);
        _selectionOrder.add(interest);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
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
              "Select at least 3 interests to personalize your Twitter experience. They will be visible on your profile.",
              style: TextStyle(
                fontSize: Sizes.size16,
                color: Colors.black54,
              ),
            ),
            Gaps.v20,
            Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey.shade300,
            ),
            Gaps.v48,
            Expanded(
              child: GridView.builder(
                // controller: _scrollController,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2, // Adjust this value as needed
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                ),
                itemCount: interests.length,
                itemBuilder: (context, index) {
                  final interest = interests[index];
                  return InterestButton(
                    interest: interest,
                    isSelected: _selectedInterests.contains(interest),
                    onTap: () => _toggleInterest(interest),
                  ); // contains 된 것만 선택
                },
              ),
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _selectedInterests.length == 3
                    ? "Great! 🔥"
                    : '${_selectedInterests.length} of 3 selected',
                style: TextStyle(
                  color: _selectedInterests.length >= 3
                      ? Colors.black
                      : Colors.grey,
                ),
              ),
              GestureDetector(
                onTap: _selectedInterests.length >= 3 ? _onNextTap : null,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: Sizes.size16 + Sizes.size2,
                    horizontal: Sizes.size24,
                  ),
                  decoration: BoxDecoration(
                    color: _selectedInterests.length >= 3
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
            ],
          ),
        ),
      ),
    );
  }
}
