// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:fi_player/functions/all_functions.dart';
import 'package:fi_player/functions/thumbnail_fetching.dart';
import 'package:fi_player/model/model.dart';
import 'package:fi_player/screens/screen_video_playing/screen_video_playing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hive_flutter/adapters.dart';
import '../widget/drawer.dart';

class VideoHistory extends StatelessWidget {
  const VideoHistory({super.key});

  @override
  Widget build(BuildContext context) {
    final playedHistoryBox = Hive.box<PlayedHistory>('played_history');
    return Scaffold(
      backgroundColor: mainBGColor,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: AppBar(
            title: Text('History'),
            actions: [
              PopupMenuButton(
                icon: const Icon(
                  Icons.more_vert,
                  color: Colors.white,
                ),
                color: mainBGColor,
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: Text('Clear History',
                        style: TextStyle(color: allTextColor)),
                    onTap: () {
                      playedHistoryListNotifier.value.clear();
                      playedHistoryBox.clear();
                      // SchedulerBinding.instance.addPostFrameCallback((_) {
                      playedHistoryListNotifier.notifyListeners();
                      // });
                    },
                  )
                ],
              )
            ],
          )),
      body: playedHistoryBox.isEmpty
          ? Center(
              child: Text(
              'No History',
              style: TextStyle(fontSize: 20),
            ))
          : Padding(
              padding: EdgeInsets.all(10),
              child: ValueListenableBuilder(
                valueListenable: playedHistoryListNotifier,
                builder: (context, value, child) => GridView.builder(
                  itemCount: playedHistoryBox.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(7),
                          child: Stack(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => VideoPlayingPage(
                                        index: 0,
                                        fromList: [
                                          playedHistoryBox.values
                                              .elementAt(
                                                  playedHistoryBox.length -
                                                      1 -
                                                      index)
                                              .video
                                        ],
                                        seekFrom: playedHistoryBox.values
                                            .elementAt(playedHistoryBox.length -
                                                1 -
                                                index)
                                            .position),
                                  ));
                                },
                                child: Container(
                                  color: Colors.black,
                                  height: 95,
                                  width: 150,
                                  child: ThumbnailWidget(
                                      videoPath: playedHistoryBox.values
                                          .elementAt(playedHistoryBox.length -
                                              1 -
                                              index)
                                          .video),
                                ),
                              ),
                              Positioned(
                                  bottom: 5,
                                  right: 5,
                                  child: VideoDuration(
                                    videoPath: playedHistoryBox.values
                                        .elementAt(
                                            playedHistoryBox.length - 1 - index)
                                        .video,
                                  )),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: SliderTheme(
                                  data: SliderTheme.of(context).copyWith(
                                    trackHeight: 4.0,
                                    overlayShape: RoundSliderOverlayShape(
                                        overlayRadius: 0),
                                    thumbShape: RoundSliderThumbShape(
                                        enabledThumbRadius: 0),
                                    activeTrackColor: Colors.purple,
                                  ),
                                  child: Slider(
                                    value: playedHistoryBox.values
                                        .elementAt(
                                            playedHistoryBox.length - 1 - index)
                                        .position
                                        .toDouble(),
                                    min: 0.0,
                                    max: playedHistoryBox.values
                                        .elementAt(
                                            playedHistoryBox.length - 1 - index)
                                        .duration
                                        .toDouble(),
                                    onChanged: (value) => {},
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        ListTile(
                          title: Text(
                            getVideoName(playedHistoryBox.values
                                .elementAt(playedHistoryBox.length - 1 - index)
                                .video),
                            style: TextStyle(color: allTextColor),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
            ),
    );
  }
}
