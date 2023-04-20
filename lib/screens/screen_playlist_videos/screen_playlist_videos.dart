import 'package:fi_player/functions/all_functions.dart';
import 'package:fi_player/model/model.dart';
import 'package:fi_player/widget/grid_view.dart';
import 'package:fi_player/widget/list_view.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
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
            body: Column(
              children: [
                ElevatedButton(
                    onPressed: () {
                      final playlistBox =
                          Hive.box<PlayList>('playlist_video'); //hive
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Center(
                              child: Container(
                            color: mainBGColor,
                            height: MediaQuery.of(context).size.height * .25,
                            width: MediaQuery.of(context).size.height * .40,
                            child: Card(
                              color: mainBGColor,
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextField(
                                      autofocus: true,
                                      decoration: const InputDecoration(
                                          labelText: 'Playlist Name',
                                          border: OutlineInputBorder()),
                                      controller: playlistController,
                                      style: TextStyle(color: allTextColor),
                                    ),
                                    const SizedBox(
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
                                            child: const Text('cancel')),
                                        ElevatedButton(
                                            onPressed: () {
                                              if (playlistController.text
                                                          .trim() !=
                                                      '' &&
                                                  !playlistKey.contains(
                                                      playlistController.text
                                                          .trim())) {
                                                final playlistModel = PlayList(
                                                    playlistName:
                                                        playlistController.text,
                                                    videosList: []);
                                                playlistBox
                                                    .add(playlistModel); //hive
                                                addplaylist(playlistController
                                                    .text
                                                    .trim());

                                                playlistController.clear();
                                                Navigator.of(context).pop();
                                                isListView.notifyListeners();
                                              }
                                            },
                                            child: const Text('add')),
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
                    child: const Text('Add Playlist')),
                const Divider(
                  height: 5,
                ),
                Expanded(
                  child: isListView.value == true
                      ? ListViewWidgetForPlaylist()
                      : GridViewWidgetForPlaylist(),
                ),
              ],
            ),
            floatingActionButton: ResumeButton(),
          );
        });
  }
}
