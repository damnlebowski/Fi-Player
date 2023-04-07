// ignore_for_file: prefer_const_constructors

import 'package:fi_player/functions/all_functions.dart';
import 'package:fi_player/functions/thumbnail_fetching.dart';
import 'package:flutter/material.dart';
import '../../widget/appbar.dart';
import '../../widget/drawer.dart';
import '../../widget/grid_view.dart';
import '../../widget/list_view.dart';

class LikedVideosPage extends StatelessWidget {
  const LikedVideosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: isListView,
        builder: (context, value, child) {
          return Scaffold(
            backgroundColor: mainBGColor,
            body: isListView.value == true
                ? ListViewWidgetForLikedVideos()
                : GridViewWidgetForLikedVideos(),
          );
        });
  }
}
