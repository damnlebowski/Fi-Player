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
                ? const Padding(
                    padding: EdgeInsets.only(top: 8, bottom: 8),
                    child: ListViewWidgetForLikedVideos(),
                  )
                : GridViewWidgetForLikedVideos(),
          );
        });
  }
}
