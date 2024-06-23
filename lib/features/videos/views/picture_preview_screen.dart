import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:tiktok_clone_assignment/features/videos/view_models/upload_video_view_model.dart';

class PicturePreviewScreen extends ConsumerStatefulWidget {
  final XFile? picture;
  final bool isPicked;

  const PicturePreviewScreen({
    super.key,
    required this.picture,
    required this.isPicked,
  });

  @override
  PicturePreviewScreenState createState() => PicturePreviewScreenState();
}

class PicturePreviewScreenState extends ConsumerState<PicturePreviewScreen> {
  bool _savedPicture = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _saveToGallery() async {
    if (_savedPicture) return;
    print(widget.picture!.path);
    if (widget.picture != null) {
      await GallerySaver.saveImage(
        widget.picture!.path,
        albumName: "TikTok Clone!",
      );
    } else {
      return;
    }

    _savedPicture = true;

    setState(() {});
  }

  Future<void> _onUploadPressed() async {
    print(widget.picture);
    if (widget.picture != null) {
      final picture = widget.picture!;
      Navigator.of(context).pop(picture);
    } else {
      return;
    }
    ref.read(uploadVideoProvider.notifier).uploadVideo(
          File(widget.picture!.path),
          context,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Preview Picture'),
        actions: [
          if (!widget.isPicked)
            IconButton(
              onPressed: _saveToGallery,
              icon: FaIcon(
                _savedPicture
                    ? FontAwesomeIcons.check
                    : FontAwesomeIcons.download,
              ),
            ),
          IconButton(
            onPressed: ref.watch(uploadVideoProvider).isLoading
                ? () {}
                : _onUploadPressed,
            icon: ref.watch(uploadVideoProvider).isLoading
                ? const CircularProgressIndicator()
                : const FaIcon(FontAwesomeIcons.cloudArrowUp),
          )
        ],
      ),
      body: Center(
        child: widget.picture != null
            ? Image.file(
                File(widget.picture!.path),
              )
            : null,
      ),
    );
  }
}
