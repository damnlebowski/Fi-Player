// ignore_for_file: prefer_const_constructors

import 'dart:developer';
import 'dart:io';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flick_video_player/flick_video_player.dart';

class VideoPlayingPage extends StatefulWidget {
  VideoPlayingPage(
      {super.key,
      required this.videoPath,
      required this.fromList,
      required this.curentIndex});
  String videoPath;
  List<String> fromList;
  int curentIndex;
  @override
  State<VideoPlayingPage> createState() => _VideoPlayingPageState();
}

class _VideoPlayingPageState extends State<VideoPlayingPage> {
  late VideoPlayerController videoPlayerController;
  late FlickManager flickManager;

  @override
  void initState() {
    // TODO: implement initState

    videoPlayerController =
        VideoPlayerController.file(File(widget.fromList[widget.curentIndex]));

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

//..........................
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            child: Icon(Icons.skip_previous),
            onPressed: () {
              if (widget.curentIndex > 0) {
                widget.curentIndex--;
                videoPlayerController.pause();
                videoPlayerController = VideoPlayerController.asset(
                    widget.fromList[widget.curentIndex])
                  ..initialize().then((_) {
                    setState(() {});
                    videoPlayerController.play();
                  });
              }
            },
          ),
          FloatingActionButton(
            heroTag: null,
            child: Icon(videoPlayerController.value.isPlaying
                ? Icons.pause
                : Icons.play_arrow),
            onPressed: () {
              setState(() {
                if (videoPlayerController.value.isPlaying) {
                  log('${widget.fromList}');
                  log('${widget.curentIndex}');
                  videoPlayerController.pause();
                } else {
                  videoPlayerController.play();
                }
              });
            },
          ),
          FloatingActionButton(
            heroTag: null,
            child: Icon(Icons.skip_next),
            onPressed: () {
              if (widget.curentIndex < widget.fromList.length - 1) {
                widget.curentIndex++;
                videoPlayerController.pause();
                videoPlayerController = VideoPlayerController.asset(
                    widget.fromList[widget.curentIndex])
                  ..initialize().then((_) {
                    setState(() {});
                    videoPlayerController.play();
                  });
              }
            },
          ),
        ],
      ),
    );
  }
}
