import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone_assignment/constants/gaps.dart';

class PostItem extends StatefulWidget {
  const PostItem({super.key});

  @override
  State<PostItem> createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  // void _onCommentsTap(BuildContext context) async {
  //   if (_videoPlayerController.value.isPlaying) {
  //     _onTogglePause();
  //   }
  //   await showModalBottomSheet(
  //     context: context,
  //     backgroundColor: Colors.transparent,
  //     builder: (context) => const BottomSheet(),
  //   );
  //   _onTogglePause();
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage('assets/1.jpeg'),
                    radius: 20,
                  ),
                  // Expanded/
                  Expanded(
                    child: Container(
                      // height: 0,
                      decoration: const BoxDecoration(
                        // borderRadius: BorderRadius.circular(50),
                        border: Border.fromBorderSide(
                          BorderSide(width: 2),
                        ),
                      ),
                      // width: 2,
                      // color: Colors.black,
                    ),
                  ),

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
                              backgroundImage: AssetImage('assets/3.jpeg'),
                              radius: 10,
                            ),
                          ),
                          CircleAvatar(
                            backgroundImage: AssetImage('assets/1.jpeg'),
                            radius: 8,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(width: 8),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'shityoushouldcareabout',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
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
                    SizedBox(height: 4),
                    Text(
                      'my phone feels like a vibrator with all these notifications rn',
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.heart,
                          size: 24,
                        ),
                        SizedBox(width: 16),
                        Icon(
                          FontAwesomeIcons.comment,
                          size: 24,
                        ),
                        SizedBox(width: 16),
                        Icon(
                          FontAwesomeIcons.paperPlane,
                          size: 24,
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text('64 replies • 631 likes'),
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
