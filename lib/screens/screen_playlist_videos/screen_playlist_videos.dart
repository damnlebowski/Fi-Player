// ignore_for_file: prefer_const_constructors

import 'package:fi_player/functions/all_functions.dart';
import 'package:fi_player/widget/grid_view.dart';
import 'package:fi_player/widget/list_view.dart';
import 'package:flutter/material.dart';
import '../../widget/appbar.dart';
import '../../widget/drawer.dart';

class PlaylistPage extends StatelessWidget {
  const PlaylistPage({super.key});

  @override
  Widget build(BuildContext context) {
    final playlistController = TextEditingController();
    return ValueListenableBuilder(
        valueListenable: isListView,
        builder: (context, value, child) {
          return Scaffold(
              backgroundColor: mainBGColor,
              floatingActionButton: FloatingActionButton(
                child: Icon(Icons.playlist_add),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Center(
                          child: SizedBox(
                        height: 200,
                        width: 300,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextField(
                                  autofocus: true,
                                  decoration: InputDecoration(
                                      labelText: 'Playlist Name',
                                      border: OutlineInputBorder()),
                                  controller: playlistController,
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    ElevatedButton(
                                        onPressed: () {
                                          playlistController.clear();
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('cancel')),
                                    ElevatedButton(
                                        onPressed: () {
                                          if (playlistController.text.trim() !=
                                                  '' &&
                                              !playlistKey.contains(
                                                  playlistController.text
                                                      .trim())) {
                                            addplaylist(
                                                playlistController.text.trim());
                                            isListView.notifyListeners();
                                            playlistController.clear();
                                            Navigator.of(context).pop();
                                          }
                                        },
                                        child: Text('add')),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ));
                    },
                  );
                },
              ),
              body: isListView.value == true
                  ? ListViewWidgetForPlaylist()
                  : GridViewWidgetForPlaylist());
        });
  }
}
