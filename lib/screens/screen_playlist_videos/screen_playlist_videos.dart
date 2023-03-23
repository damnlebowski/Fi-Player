// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../../widget/appbar.dart';
import '../../widget/drawer.dart';


class PlaylistPage extends StatelessWidget {
  const PlaylistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: isListView,
        builder: (context, value, child) {
          return Scaffold(
              backgroundColor: mainBGColor,
              // body: isListView.value == true
              //     ? ListViewWidget(
              //         title: 'Video playlist',
              //         nextPage: FolderPage(),
              //         icon: Icons.folder,
              //       )
              //     : GridViewWidget(
              //         title: 'Video playlist',
              //         nextPage: FolderPage(),
              //         icon: Icons.folder,
              // )
              );
        });
  }
}
