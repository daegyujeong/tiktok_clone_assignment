import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone_assignment/constants/gaps.dart';
import 'package:tiktok_clone_assignment/constants/sizes.dart';

class PostItemWithPhotos extends StatefulWidget {
  const PostItemWithPhotos({super.key});

  @override
  State<PostItemWithPhotos> createState() => _PostItemWithPhotosState();
}

class _PostItemWithPhotosState extends State<PostItemWithPhotos> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 상단: 프로필 및 유저 정보
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 프로필 아바타 및 연결된 선 (예제에서는 PostItem과 비슷하게 구성)
              Column(
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage('assets/1.jpeg'),
                    radius: 20,
                  ),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        border: Border.fromBorderSide(
                          BorderSide(width: 2),
                        ),
                      ),
                    ),
                  ),
                  // 예시로 여러 아바타가 겹쳐진 모습
                  const Row(
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            top: -35,
                            child: CircleAvatar(
                              backgroundImage: AssetImage('assets/2.jpeg'),
                              radius: 15,
                            ),
                          ),
                          Positioned(
                            left: -20,
                            top: -20,
                            child: CircleAvatar(
                              backgroundImage: AssetImage('assets/1.jpeg'),
                              radius: 10,
                            ),
                          ),
                          CircleAvatar(
                            backgroundImage: AssetImage('assets/2.jpeg'),
                            radius: 8,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(width: 8),
              // 유저 이름, 설명, 이미지 캐러셀 및 하단 정보
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 유저 정보 헤더
                    const Row(
                      children: [
                        Expanded(
                          child: Text(
                            'post_with_photos_user',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Icon(
                          Icons.verified,
                          color: Colors.blue,
                          size: 16,
                        ),
                        SizedBox(width: 8),
                        Text('2h'),
                        SizedBox(width: 8),
                        Icon(Icons.more_horiz),
                      ],
                    ),
                    const SizedBox(height: 4),
                    // 포스트 설명 텍스트
                    const Text(
                      'Check out these cool photos!',
                    ),
                    const SizedBox(height: 8),
                    // 이미지 캐러셀 영역 (PageView 사용)
                    SizedBox(
                      height: 300,
                      width: double.infinity,
                      child: PageView(
                        controller: _pageController,
                        onPageChanged: (index) {
                          setState(() {
                            _currentPage = index;
                          });
                        },
                        children: [
                          Image.asset(
                            'assets/1.jpeg',
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                          Image.asset(
                            'assets/2.jpeg',
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ],
                      ),
                    ),
                    // Page Indicator (선택된 페이지 표시)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        2,
                        (index) => Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 2, vertical: 8),
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentPage == index
                                ? Colors.black
                                : Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // 좋아요, 댓글, 공유 아이콘
                    const Row(
                      children: [
                        Icon(FontAwesomeIcons.heart, size: 24),
                        SizedBox(width: 16),
                        Icon(FontAwesomeIcons.comment, size: 24),
                        SizedBox(width: 16),
                        Icon(FontAwesomeIcons.paperPlane, size: 24),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text('64 replies • 631 likes'),
                  ],
                ),
              ),
            ],
          ),
        ),
        Gaps.v40,
      ],
    );
  }
}
