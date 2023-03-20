// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';


import '../../widget/appbar.dart';
import '../../widget/grid_view.dart';
import '../../widget/list_view.dart';
import '../screen_folder/screen_folder.dart';


class LocalFolderPage extends StatelessWidget {
  const LocalFolderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      backgroundColor: Colors.purple[50],
      body: isListView == true
          ? ListViewWidget(
              title: 'Folder', nextPage: FolderPage(), icon: Icons.folder)
          : GridViewWidget(
              title: 'Folder',
              nextPage: FolderPage(),
              icon: Icons.folder,
            ),
    );
  }
}

