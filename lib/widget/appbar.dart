// ignore_for_file: prefer_const_constructors

import 'package:fi_player/functions/all_functions.dart';
import 'package:fi_player/screens/screen_search/screen_search.dart';
import 'package:flutter/material.dart';
import 'drawer.dart';

ValueNotifier<bool> isListView = ValueNotifier(true);

class AppBarWidget extends StatefulWidget {
  const AppBarWidget({super.key});

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      // leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
      title: Text('Fi Player'),
      actions: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
                onPressed: () {
                  setState(() {
                    if (isListView.value == true) {
                      isListView.value = false;
                      // isDarkMode.notifyListeners();
                    } else {
                      isListView.value = true;
                      // isDarkMode.notifyListeners();
                    }
                  });
                },
                icon: isListView.value == true
                    ? Icon(Icons.grid_view_sharp)
                    : Icon(Icons.format_list_numbered_sharp)),
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SearchPage(),
                  ));
                },
                icon: Icon(Icons.search)),
            PopupMenuButton(
              icon: Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
              color: mainBGColor,
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: Text('Refresh', style: TextStyle(color: allTextColor)),
                  onTap: () {
                    likedVideoNotify.value.clear();
                    playlist.clear();
                    playlistKey.clear();
                    isListView.notifyListeners();
                  },
                )
              ],
            )
          ],
        ),
      ],
    );
  }
}
