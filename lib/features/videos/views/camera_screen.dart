import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tiktok_clone_assignment/constants/gaps.dart';
import 'package:tiktok_clone_assignment/constants/sizes.dart';
import 'package:tiktok_clone_assignment/features/videos/views/picture_preview_screen.dart';
import 'package:tiktok_clone_assignment/features/videos/views/video_preview_screen.dart';

class CameraScreen extends StatefulWidget {
  static const String routeName = "postVideo";
  static const String routeURL = "/upload";
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  bool _hasPermission = false;

  bool _isSelfieMode = false;

  late final bool _noCamera = kDebugMode && Platform.isIOS;

  late final AnimationController _buttonAnimationController =
      AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 200),
  );

  late final Animation<double> _buttonAnimation =
      Tween(begin: 1.0, end: 1.3).animate(_buttonAnimationController);

  late final AnimationController _progressAnimationController =
      AnimationController(
    vsync: this,
    duration: const Duration(seconds: 10),
    lowerBound: 0.0,
    upperBound: 1.0,
  );

  late FlashMode _flashMode;
  late CameraController _cameraController;

  @override
  void initState() {
    super.initState();
    print("CameraScreen");
    if (!_noCamera) {
      initPermissions();
    } else {
      setState(() {
        _hasPermission = true;
      });
    }
    WidgetsBinding.instance.addObserver(this);
    _progressAnimationController.addListener(() {
      setState(() {});
    });
    _progressAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _takePicture();
      }
    });
  }

  @override
  void dispose() {
    _progressAnimationController.dispose();
    _buttonAnimationController.dispose();
    if (!_noCamera) {
      _cameraController.dispose();
    }
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_noCamera) return;
    if (!_hasPermission) return;
    if (!_cameraController.value.isInitialized) return;
    if (state == AppLifecycleState.inactive) {
      _cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      initCamera();
    }
  }

  Future<void> initCamera() async {
    final cameras = await availableCameras();
    print("This is camera \n $cameras");
    if (cameras.isEmpty) {
      return;
    }

    _cameraController = CameraController(
      cameras[_isSelfieMode ? 1 : 0],
      ResolutionPreset.ultraHigh,
      enableAudio: false,
    );

    try {
      await _cameraController.initialize();
      await _cameraController.prepareForVideoRecording();
    } catch (e) {
      print('Error initializing camera: $e');
    }
    _flashMode = _cameraController.value.flashMode;

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> initPermissions() async {
    print("check permission");
    final cameraPermission = await Permission.camera.request();
    final micPermission = await Permission.microphone.request();
    // final storagePermission = await Permission.storage.request();
    // print(storagePermission);
    if (cameraPermission.isGranted && micPermission.isGranted)
    //  && storagePermission.isGranted)
    {
      _hasPermission = true;
      await initCamera();
      if (mounted) {
        setState(() {});
      }
    }
  }

  Future<void> _toggleSelfieMode() async {
    _isSelfieMode = !_isSelfieMode;
    await initCamera();
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _setFlashMode(FlashMode newFlashMode) async {
    await _cameraController.setFlashMode(newFlashMode);
    _flashMode = newFlashMode;
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _takePictureReady(TapDownDetails _) async {
    // print("video recording !!!");
    // if (_cameraController.value.isRecordingVideo) {
    //   print("video recording !!!");
    //   return;
    // }

    // await _cameraController.startVideoRecording();

    _buttonAnimationController.forward();
    // _progressAnimationController.forward();
  }

  Future<void> _takePicture() async {
    final picture = await _cameraController.takePicture();
    if (!mounted) return;
    XFile? uploadPicture = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PicturePreviewScreen(
          picture: picture,
          isPicked: false,
        ),
      ),
    );

    if (!mounted) return;
    print(uploadPicture);
    Navigator.of(context).pop(uploadPicture);

    // if (!_cameraController.value.isRecordingVideo) return;

    // print("video stopping !!!");

    // _buttonAnimationController.reverse();
    // _progressAnimationController.reset();

    // try {
    //   // final video = await _cameraController.stopVideoRecording();
    //   final video = await _cameraController.stop

    //   if (!mounted) return;

    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => VideoPreviewScreen(
    //         video: video,
    //         isPicked: false,
    //       ),
    //     ),
    //   );
    // } catch (e) {
    //   print('Error stopping video recording: $e');
    //   // Handle error appropriately
    // }
  }

  Future<void> _onPickVideoPressed() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (image == null) return;

    if (!mounted) return;
    XFile? uploadPicture = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PicturePreviewScreen(
          picture: image,
          isPicked: true,
        ),
      ),
    );

    if (!mounted) return;
    print(uploadPicture);
    Navigator.of(context).pop(uploadPicture);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: !_hasPermission
            ? const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Initializing...",
                    style:
                        TextStyle(color: Colors.white, fontSize: Sizes.size20),
                  ),
                  Gaps.v20,
                  CircularProgressIndicator.adaptive()
                ],
              )
            : Stack(
                alignment: Alignment.center,
                children: [
                  if (!_noCamera && _cameraController.value.isInitialized)
                    CameraPreview(_cameraController),
                  const Positioned(
                    top: Sizes.size40,
                    left: Sizes.size20,
                    child: CloseButton(
                      color: Colors.white,
                    ),
                  ),
                  if (!_noCamera)
                    Positioned(
                      top: Sizes.size20,
                      right: Sizes.size20,
                      child: Column(
                        children: [
                          IconButton(
                            color: Colors.white,
                            onPressed: _toggleSelfieMode,
                            icon: const Icon(
                              Icons.cameraswitch,
                            ),
                          ),
                          Gaps.v10,
                          IconButton(
                            color: _flashMode == FlashMode.off
                                ? Colors.amber.shade200
                                : Colors.white,
                            onPressed: () => _setFlashMode(FlashMode.off),
                            icon: const Icon(
                              Icons.flash_off_rounded,
                            ),
                          ),
                          Gaps.v10,
                          IconButton(
                            color: _flashMode == FlashMode.always
                                ? Colors.amber.shade200
                                : Colors.white,
                            onPressed: () => _setFlashMode(FlashMode.always),
                            icon: const Icon(
                              Icons.flash_on_rounded,
                            ),
                          ),
                          Gaps.v10,
                          IconButton(
                            color: _flashMode == FlashMode.auto
                                ? Colors.amber.shade200
                                : Colors.white,
                            onPressed: () => _setFlashMode(FlashMode.auto),
                            icon: const Icon(
                              Icons.flash_auto_rounded,
                            ),
                          ),
                          Gaps.v10,
                          IconButton(
                            color: _flashMode == FlashMode.torch
                                ? Colors.amber.shade200
                                : Colors.white,
                            onPressed: () => _setFlashMode(FlashMode.torch),
                            icon: const Icon(
                              Icons.flashlight_on_rounded,
                            ),
                          ),
                        ],
                      ),
                    ),
                  Positioned(
                    bottom: Sizes.size40,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        const Spacer(),
                        GestureDetector(
                          onTapDown: _takePictureReady,
                          onTapUp: (details) => _takePicture(),
                          child: ScaleTransition(
                            scale: _buttonAnimation,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                SizedBox(
                                  width: Sizes.size80 + Sizes.size14,
                                  height: Sizes.size80 + Sizes.size14,
                                  child: CircularProgressIndicator(
                                    color: Colors.red.shade400,
                                    strokeWidth: Sizes.size6,
                                    value: _progressAnimationController.value,
                                  ),
                                ),
                                Container(
                                  width: Sizes.size80,
                                  height: Sizes.size80,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.red.shade400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: IconButton(
                              onPressed: _onPickVideoPressed,
                              icon: const FaIcon(
                                FontAwesomeIcons.image,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
