import 'package:flutter/material.dart';
import '../../functions/all_functions.dart';
import '../../widget/appbar.dart';
import '../../widget/drawer.dart';
import '../../widget/grid_view.dart';
import '../../widget/list_view.dart';

class PlaylistInsidePage extends StatelessWidget {
  PlaylistInsidePage({super.key, required this.playlistIndex});
  int playlistIndex;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: isListView,
        builder: (context, value, child) {
          return Scaffold(
              backgroundColor: mainBGColor,
              appBar: const PreferredSize(
                  preferredSize: Size.fromHeight(70), child: AppBarWidget()),
              body: isListView.value == true
                  ? Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 8),
                      child: ListViewWidgetForInnerPlaylist(
                        fromPlaylistName: playlistKey[playlistIndex],
                      ),
                    )
                  : GridViewWidgetForInnerPlaylist(
                      fromPlaylistName: playlistKey[playlistIndex],
                    ));
        });
  }
}
