import 'dart:ffi';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone_assignment/constants/sizes.dart';
import 'package:tiktok_clone_assignment/features/videos/views/camera_screen.dart';
import 'package:tiktok_clone_assignment/features/videos/views/video_recording_screen.dart';
import 'package:tiktok_clone_assignment/utils.dart';

class WriteScreen extends StatefulWidget {
  final File? image;

  const WriteScreen({super.key, this.image});

  @override
  State<WriteScreen> createState() => _WriteScreenState();
}

class _WriteScreenState extends State<WriteScreen> {
  final TextEditingController _controller = TextEditingController();
  XFile? _uploadPicture;
  Future<void> _onPaperclipPress() async {
    _uploadPicture = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CameraScreen(),
      ),
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: SizedBox(
            width: 80, // Set the desired width here
            child: TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                    color: isDarkMode(context) ? Colors.grey : Colors.black),
              ),
            ),
          ),
          title: const Text('New thread'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        const CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(
                              "https://avatars.githubusercontent.com/u/3612017"),
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                          child: Container(
                            width: 2,
                            color: isDarkMode(context)
                                ? Colors.grey
                                : Colors.black,
                          ),
                        ),
                        const CircleAvatar(
                          radius: 10,
                          backgroundImage: NetworkImage(
                              "https://avatars.githubusercontent.com/u/3612017"),
                        ),
                      ],
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "jane_mobbin",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: Sizes.size16,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Expanded(
                            child: TextField(
                              controller: _controller,
                              maxLines: null,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "How's today? Share your thoughts...",
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          if (_uploadPicture != null)
                            Container(
                              width: 300,
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image: FileImage(File(_uploadPicture!.path)),
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            )
                          else
                            const SizedBox.shrink(),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              IconButton(
                                onPressed: _onPaperclipPress,
                                icon: const FaIcon(FontAwesomeIcons.paperclip),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              const Divider(),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  "Anyone can reply",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
