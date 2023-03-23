// ignore_for_file: prefer_const_constructors

import 'package:fi_player/functions/all_functions.dart';
import 'package:flutter/material.dart';
import '../../widget/appbar.dart';
import '../../widget/drawer.dart';
import '../../widget/grid_view.dart';
import '../../widget/list_view.dart';

class AllVideosPage extends StatelessWidget {
  const AllVideosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: isListView,
        builder: (context, value, child) {
          return Scaffold(
            backgroundColor: mainBGColor,
            body: isListView.value == true
                ? ListViewWidgetForVideos(
                    notifier: allVideosNotify,
                  )
                : GridViewWidgetForVideos(),
          );
        });
  }
}
