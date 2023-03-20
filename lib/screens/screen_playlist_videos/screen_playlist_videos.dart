// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../../widget/appbar.dart';
import '../../widget/drawer.dart';
import '../../widget/grid_view.dart';
import '../../widget/list_view.dart';
import '../screen_folder/screen_folder.dart';

class PlaylistPage extends StatelessWidget {
  const PlaylistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: mainBGColor,
        body: isListView == true
            ? ListViewWidget(
                title: 'Video playlist',
                nextPage: FolderPage(),
                icon: Icons.folder,
              )
            : GridViewWidget(
                title: 'Video playlist',
                nextPage: FolderPage(),
                icon: Icons.folder,
              ));
  }
}
