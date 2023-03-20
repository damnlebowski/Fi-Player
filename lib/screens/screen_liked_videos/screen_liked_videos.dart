// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../widget/appbar.dart';
import '../../widget/grid_view.dart';
import '../../widget/list_view.dart';
import '../screen_video_playing/screen_video_playing.dart';

class LikedVideosPage extends StatelessWidget {
  const LikedVideosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[50],
      body: isListView == true
          ? ListViewWidget(title: 'Liked Video', nextPage: VideoPlayingPage(),icon: Icons.video_file_outlined,)
          : GridViewWidget(title: 'Liked video', nextPage: VideoPlayingPage(),icon: Icons.video_file_outlined)
    );
  }
}
