// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:flick_video_player/flick_video_player.dart';

class VideoPlayingPage extends StatefulWidget {
  VideoPlayingPage({super.key, required String this.videoPath});
  String videoPath;
  @override
  State<VideoPlayingPage> createState() => _VideoPlayingPageState();
}

class _VideoPlayingPageState extends State<VideoPlayingPage> {
  late VideoPlayerController videoPlayerController;
  late FlickManager flickManager;

  @override
  void initState() {
    // TODO: implement initState

    videoPlayerController = VideoPlayerController.file(File(widget.videoPath));

    flickManager = FlickManager(videoPlayerController: videoPlayerController);

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    videoPlayerController.dispose();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: FlickVideoPlayer(
      flickManager: flickManager,
      flickVideoWithControls: FlickVideoWithControls(
        controls: FlickPortraitControls(),
        videoFit: BoxFit.contain,
      ),
      // flickVideoWithControlsFullscreen: FlickVideoWithControls(
      //   controls: FlickLandscapeControls(),
      //   videoFit: BoxFit.contain,
      // ),
      // wakelockEnabled: true,
      // preferredDeviceOrientation: const [
      //   DeviceOrientation.portraitUp,
      //   DeviceOrientation.portraitDown,
      //   DeviceOrientation.landscapeRight,
      //   DeviceOrientation.landscapeLeft
      // ],
    ));
  }
}
