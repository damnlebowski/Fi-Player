// ignore_for_file: sort_child_properties_last, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:fi_player/functions/all_functions.dart';
import 'package:fi_player/functions/thumbnail_fetching.dart';
import 'package:flutter/material.dart';
import '../../widget/appbar.dart';
import '../../widget/drawer.dart';
import '../../widget/grid_view.dart';
import '../../widget/list_view.dart';

class FolderInnerPage extends StatelessWidget {
  FolderInnerPage({super.key, required this.folderAddress});

  String folderAddress;
  @override
  Widget build(BuildContext context) {
    List<String> innerFolderData = getInnerFolderData(folderAddress);
    return ValueListenableBuilder(
        valueListenable: isListView,
        builder: (context, value, child) {
          return Scaffold(
              backgroundColor: mainBGColor,
              appBar: PreferredSize(
                  child: AppBarWidget(), preferredSize: Size.fromHeight(70)),
              body: isListView.value == true
                  ? ListViewWidgetForInnerVideos(
                      innerFolderData: innerFolderData,
                    )
                  : GridViewWidgetForInnerVideos(
                      innerFolderData: innerFolderData));
        });
  }
}
