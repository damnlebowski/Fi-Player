// ignore_for_file: sort_child_properties_last, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import '../../widget/appbar.dart';
import '../../widget/drawer.dart';
import '../../widget/grid_view.dart';
import '../../widget/list_view.dart';
import '../screen_video_playing/screen_video_playing.dart';

class FolderPage extends StatelessWidget {
  const FolderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: isListView,
        builder: (context, value, child) {
          return Scaffold(
              backgroundColor: mainBGColor,
              // appBar: PreferredSize(
              //     child: AppBarWidget(), preferredSize: Size.fromHeight(70)),
              // body: isListView.value == true
              //     ? ListViewWidget(
              //         title: 'Video',
              //         nextPage: VideoPlayingPage(),
              //         icon: Icons.video_file_outlined,
              //       )
              //     : GridViewWidget(
              //         title: 'Video',
              //         nextPage: VideoPlayingPage(),
              //         icon: Icons.video_file_outlined,
              //       ),
              );
        });
  }
}
