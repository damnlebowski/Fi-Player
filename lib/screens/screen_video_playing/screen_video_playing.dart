import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:auto_orientation/auto_orientation.dart';
import 'package:fi_player/functions/all_functions.dart';
import 'package:fi_player/model/model.dart';
import 'package:fi_player/widget/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock/wakelock.dart';

class VideoPlayingPage extends StatefulWidget {
  VideoPlayingPage(
      {super.key,
      required this.index,
      required this.fromList,
      required this.seekFrom});
  int index;
  List<String> fromList;
  int seekFrom;

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
  String playingVideoPath = '';
  @override
  void initState() {
    // print('----------------------------$isLikeVisible');
    super.initState();
    //..................................kodukanam
    playingVideoPath = widget.fromList[widget.index];
    controller = VideoPlayerController.file(File(playingVideoPath))
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize().then((_) {
        controller.seekTo(Duration(seconds: widget.seekFrom));
        setPlayingOrientation();
        Future.delayed(const Duration(seconds: 3))
            .then((_) => isVisible = false);
      });
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
    storeLastPlayed();

    setAllOrientationToDefault();
    addToPlayedHistory(playingVideoPath, controller.value.position.inSeconds,
        controller.value.duration.inSeconds);
    controller.dispose();

    super.dispose();
  }

  storeLastPlayed() async {
    final lastPlayedBox = Hive.box<LastPlayed>('last_played');
    final lastPlayedModel = LastPlayed(
        video: playingVideoPath, position: controller.value.position.inSeconds);
    await lastPlayedBox.clear();
    await lastPlayedBox.add(lastPlayedModel);
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
                        Future.delayed(const Duration(seconds: 3))
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
                          child: Stack(
                            children: [VideoPlayer(controller)],
                          )),
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
                        onTap: () {
                          setState(() {
                            if (isVisible == false) {
                              isVisible = true;
                              Future.delayed(const Duration(seconds: 3))
                                  .then((_) => isVisible = false);
                            } else {
                              isVisible = false;
                            }
                          });
                        },
                        onDoubleTap: () {
                          controller.seekTo(controller.value.position -
                              const Duration(seconds: 10));
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
                        onTap: () {
                          setState(() {
                            if (isVisible == false) {
                              isVisible = true;
                              Future.delayed(const Duration(seconds: 3))
                                  .then((_) => isVisible = false);
                            } else {
                              isVisible = false;
                            }
                          });
                        },
                        onDoubleTap: () {
                          controller.seekTo(controller.value.position +
                              const Duration(seconds: 10));
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
              : const Center(
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
      child: ListTile(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.purple,
            )),
        title: Text(
          getVideoName(widget.fromList[widget.index]),
          style: const TextStyle(
              color: Colors.purple, overflow: TextOverflow.ellipsis),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FavIconWidget(video: playingVideoPath, fromList: widget.fromList),
            PopupMenuButton(
              icon: const Icon(
                Icons.more_vert,
                color: Colors.purple,
              ),
              color: Colors.black.withOpacity(.5),
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: const Text(
                    '0.25x',
                    style: TextStyle(color: Colors.purple),
                  ),
                  onTap: () {
                    controller.setPlaybackSpeed(0.25);
                  },
                ),
                PopupMenuItem(
                  child: const Text(
                    '0.50x',
                    style: TextStyle(color: Colors.purple),
                  ),
                  onTap: () {
                    controller.setPlaybackSpeed(0.50);
                  },
                ),
                PopupMenuItem(
                  child: const Text(
                    '1.00x',
                    style: TextStyle(color: Colors.purple),
                  ),
                  onTap: () {
                    controller.setPlaybackSpeed(1.00);
                  },
                ),
                PopupMenuItem(
                  child: const Text(
                    '1.25x',
                    style: TextStyle(color: Colors.purple),
                  ),
                  onTap: () {
                    controller.setPlaybackSpeed(1.25);
                  },
                ),
                PopupMenuItem(
                  child: const Text(
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
      ),
    );
  }

  Container videoBottomControlBar() {
    return Container(
      height: 100,
      color: Colors.black.withOpacity(.5),
      child: Column(
        children: [
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              videoDuration(controller: controller),
              Expanded(child: buildIndicator()),
              SizedBox(
                width: 50,
                child: Text(
                  convertMillisecondsToTime(
                      controller.value.duration.inMilliseconds),
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(
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
                icon: const Icon(
                  Icons.skip_previous,
                  color: Colors.purple,
                ),
                onPressed: () {
                  isVisible = false;
                  isVisible = true;
                  if (widget.index > 0) {
                    widget.index--;
                    controller.pause();
                    addToPlayedHistory(
                        playingVideoPath,
                        controller.value.position.inSeconds,
                        controller.value.duration.inSeconds);
                    playingVideoPath = widget.fromList[widget.index];

                    controller =
                        VideoPlayerController.file(File(playingVideoPath))
                          ..addListener(() => setState(() {}))
                          ..setLooping(true)
                          ..initialize().then((_) {
                            setPlayingOrientation();
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
                icon: const Icon(
                  Icons.skip_next,
                  color: Colors.purple,
                ),
                onPressed: () {
                  isVisible = false;
                  isVisible = true;
                  if (widget.index < widget.fromList.length - 1) {
                    widget.index++;
                    controller.pause();
                    addToPlayedHistory(
                        playingVideoPath,
                        controller.value.position.inSeconds,
                        controller.value.duration.inSeconds);
                    playingVideoPath = widget.fromList[widget.index];

                    controller =
                        VideoPlayerController.file(File(playingVideoPath))
                          ..addListener(() => setState(() {}))
                          ..setLooping(true)
                          ..initialize().then((_) {
                            setPlayingOrientation();
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
                  icon: const Icon(
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

class FavIconWidget extends StatefulWidget {
  FavIconWidget({super.key, required this.video, required this.fromList});
  String video;
  List<String> fromList;

  @override
  State<FavIconWidget> createState() => _FavIconWidgetState();
}

class _FavIconWidgetState extends State<FavIconWidget> {
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.fromList != likedVideoList ? true : false,
      child: IconButton(
          onPressed: () {
            setState(() {
              if (!likedVideoList.contains(widget.video)) {
                addLikedVideo(context, widget.video);
              } else {
                removeLikedVideo(likedVideoList.indexOf(widget.video), context);

                return;
              }
            });
          },
          icon: Icon(
            likedVideoList.contains(widget.video)
                ? Icons.favorite
                : Icons.favorite_border,
            color: Colors.purple,
          )),
    );
  }
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
    return SizedBox(
      width: 50,
      child: Text(
        _position,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white, fontSize: 15),
      ),
    );
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
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
