import 'package:fi_player/functions/all_functions.dart';
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
              appBar: const PreferredSize(
                  preferredSize: Size.fromHeight(70), child: AppBarWidget()),
              body: isListView.value == true
                  ? Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 8),
                      child: ListViewWidgetForInnerVideos(
                        innerFolderData: innerFolderData,
                      ),
                    )
                  : GridViewWidgetForInnerVideos(
                      innerFolderData: innerFolderData));
        });
  }
}
