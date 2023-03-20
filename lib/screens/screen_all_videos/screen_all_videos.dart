// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../widget/appbar.dart';
import '../../widget/grid_view.dart';
import '../../widget/list_view.dart';
import '../screen_video_playing/screen_video_playing.dart';

class AllVideosPage extends StatelessWidget {
  const AllVideosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[50],
      body: isListView == true
          ? ListViewWidgetForVideos(
              title: 'Video', nextPage: VideoPlayingPage())
          : GridViewWidgetForVideos(
              title: 'Video', nextPage: VideoPlayingPage()),
    );
  }
}
