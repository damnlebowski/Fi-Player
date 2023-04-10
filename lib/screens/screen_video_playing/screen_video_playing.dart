// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:auto_orientation/auto_orientation.dart';
import 'package:fi_player/functions/all_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock/wakelock.dart';

import '../../widget/drawer.dart';

class VideoPlayingPage extends StatefulWidget {
  VideoPlayingPage({super.key, required this.index, required this.fromList});
  int index;
  List<String> fromList;

  @override
  State<VideoPlayingPage> createState() => _VideoPlayingPageState();
}

bool isPotrait = true;

Future setLandscape() async {
  await Wakelock.enable();
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  AutoOrientation.landscapeAutoMode();
  isPotrait = false;
}

Future setPotrait() async {
  await Wakelock.enable();
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  AutoOrientation.portraitUpMode();
  isPotrait = true;
}

bool isVisible = true;

class _VideoPlayingPageState extends State<VideoPlayingPage> {
  late VideoPlayerController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = VideoPlayerController.file(File(widget.fromList[widget.index]))
      ..addListener(
        () => setState(() {}),
      )
      ..setLooping(true)
      ..initialize().then((_) => setPlayingOrientation());
  }

  setPlayingOrientation() async {
    await controller.play();
    if (controller.value.isPlaying) {
      log('playing.....................');
      if (controller.value.size.width > controller.value.size.height) {
        log('landscape.....................');
        setLandscape();
      } else {
        log('potrait.....................');
        setPotrait();
      }
    } else {
      log('not playing.................');
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    setAllOrientationToDefault();
    controller.dispose();
    super.dispose();
  }

  Future setAllOrientationToDefault() async {
    await AutoOrientation.portraitUpMode();
    await Wakelock.disable();
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);

    isPotrait = true;
  }

  @override
  Widget build(BuildContext context) {
    final isMuted = controller.value.volume == 0;
    bool skipPluse = true;
    bool skipMinus = false;
    return Scaffold(
      body: Container(
          color: Colors.black,
          child: controller != null && controller.value.isInitialized
              ? GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    setState(() {
                      if (isVisible == false) {
                        isVisible = true;
                        Future.delayed(Duration(seconds: 3))
                            .then((_) => isVisible = false);
                      } else {
                        isVisible = false;
                      }
                    });
                  },
                  child: Stack(children: [
                    Center(
                      child: AspectRatio(
                          aspectRatio: controller.value.aspectRatio,
                          child: VideoPlayer(controller)),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Visibility(
                        visible: isVisible,
                        child: videoTopControlBar(context),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      top: 120,
                      bottom: 120,
                      width: 160,
                      child: InkWell(
                        onDoubleTap: () {
                          controller.seekTo(controller.value.position -
                              Duration(seconds: 10));
                        },
                        child: Container(),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 120,
                      bottom: 120,
                      width: 160,
                      child: InkWell(
                        onDoubleTap: () {
                          skipPluse = false;

                          controller.seekTo(controller.value.position +
                              Duration(seconds: 10));
                          setState(() {});
                        },
                        child: Container(),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Visibility(
                        visible: isVisible,
                        child: videoBottomControlBar(),
                      ),
                    )
                  ]),
                )
              : Center(
                  child: SizedBox(
                      height: 200,
                      child: Center(child: CircularProgressIndicator())),
                )),
    );
  }

  Container videoTopControlBar(BuildContext context) {
    return Container(
      height: 50,
      color: Colors.black.withOpacity(.5),
      child: Row(
        children: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.purple,
              )),
          Spacer(),
          IconButton(
              onPressed: () {
                if (!likedVideoNotify.value
                    .contains(widget.fromList[widget.index])) {
                  addLikedVideo(widget.index, context, widget.fromList);
                } else {
                  removeLikedVideo(
                      likedVideoNotify.value
                          .indexOf(widget.fromList[widget.index]),
                      context);
                }
                setState(() {});
              },
              icon: Icon(
                likedVideoNotify.value.contains(widget.fromList[widget.index])
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: Colors.purple,
              )),
          PopupMenuButton(
            icon: Icon(
              Icons.more_vert,
              color: Colors.purple,
            ),
            color: Colors.black.withOpacity(.5),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text(
                  '0.25x',
                  style: TextStyle(color: Colors.purple),
                ),
                onTap: () {
                  controller.setPlaybackSpeed(0.25);
                },
              ),
              PopupMenuItem(
                child: Text(
                  '0.50x',
                  style: TextStyle(color: Colors.purple),
                ),
                onTap: () {
                  controller.setPlaybackSpeed(0.50);
                },
              ),
              PopupMenuItem(
                child: Text(
                  '1.00x',
                  style: TextStyle(color: Colors.purple),
                ),
                onTap: () {
                  controller.setPlaybackSpeed(1.00);
                },
              ),
              PopupMenuItem(
                child: Text(
                  '1.25x',
                  style: TextStyle(color: Colors.purple),
                ),
                onTap: () {
                  controller.setPlaybackSpeed(1.25);
                },
              ),
              PopupMenuItem(
                child: Text(
                  '1.50x',
                  style: TextStyle(color: Colors.purple),
                ),
                onTap: () {
                  controller.setPlaybackSpeed(1.50);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container videoBottomControlBar() {
    return Container(
      height: 100,
      color: Colors.black.withOpacity(.5),
      child: Column(
        children: [
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              videoDuration(controller: controller),
              Expanded(child: buildIndicator()),
              Text(
                convertMillisecondsToTime(
                    controller.value.duration.inMilliseconds),
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: () {
                    if (controller.value.volume != 0) {
                      controller.setVolume(0);
                    } else {
                      controller.setVolume(1);
                    }
                  },
                  icon: Icon(
                    controller.value.volume != 0
                        ? Icons.volume_up
                        : Icons.volume_off,
                    color: Colors.purple,
                  )),
              IconButton(
                icon: Icon(
                  Icons.skip_previous,
                  color: Colors.purple,
                ),
                onPressed: () {
                  if (widget.index > 0) {
                    widget.index--;
                    controller.pause();
                    controller = VideoPlayerController.file(
                        File(widget.fromList[widget.index]))
                      ..initialize().then((_) {
                        setState(() {
                          setPlayingOrientation();
                        });
                        controller.play();
                      });
                  }
                },
              ),
              IconButton(
                icon: Icon(
                  controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.purple,
                ),
                onPressed: () {
                  if (controller.value.isPlaying) {
                    controller.pause();
                  } else {
                    controller.play();
                  }
                  setState(() {});
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.skip_next,
                  color: Colors.purple,
                ),
                onPressed: () {
                  log('${widget.fromList[widget.index]}');
                  if (widget.index < widget.fromList.length - 1) {
                    widget.index++;
                    log('${widget.fromList[widget.index]}');
                    controller.pause();
                    controller = VideoPlayerController.file(
                        File(widget.fromList[widget.index]))
                      ..initialize().then((_) {
                        setState(() {
                          setPlayingOrientation();
                        });
                      });

                    controller.play();
                  }
                },
              ),
              IconButton(
                  onPressed: () {
                    if (isPotrait) {
                      setLandscape();
                    } else {
                      setPotrait();
                    }
                  },
                  icon: Icon(
                    Icons.screen_rotation,
                    color: Colors.purple,
                  )),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildIndicator() => Padding(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: VideoProgressIndicator(
          controller,
          allowScrubbing: true,
          colors: VideoProgressColors(
              playedColor: Colors.purple, backgroundColor: Colors.purple[100]!),
        ),
      );
}

class videoDuration extends StatefulWidget {
  videoDuration({super.key, required this.controller});
  VideoPlayerController controller;

  @override
  State<videoDuration> createState() => _videoDurationState();
}

class _videoDurationState extends State<videoDuration> {
  Timer? _timer;
  late String _position =
      '${convertMillisecondsToTime(widget.controller.value.position.inMilliseconds)}';

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _position,
      style: TextStyle(color: Colors.white, fontSize: 15),
    );
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      final duration = Duration(
          milliseconds:
              widget.controller.value.position.inMilliseconds.round());
      setState(() {
        _position = convertMillisecondsToTime(
            widget.controller.value.position.inMilliseconds);
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }
}

// class videoDuration extends StatefulWidget {
//   videoDuration({super.key, required this.controller});
//   VideoPlayerController controller;

//   @override
//   State<videoDuration> createState() => _videoDurationState();
// }

// class _videoDurationState extends State<videoDuration> {
//   String _position = '';

//   @override
//   void initState() {
//     super.initState();
//     widget.controller.addListener(_updatePosition);
//   }

//   @override
//   void dispose() {
//     widget.controller.removeListener(_updatePosition);
//     super.dispose();
//   }

//   void _updatePosition() {
//     final duration = Duration(
//         milliseconds: widget.controller.value.position.inMilliseconds.round());
//     final position = [duration.inMinutes, duration.inSeconds]
//         .map((e) => e.remainder(60).toString().padLeft(2, '0'))
//         .join(':');
//     setState(() {
//       _position = position;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       _position,
//       style: TextStyle(color: Colors.white, fontSize: 15),
//     );
//   }
// }
