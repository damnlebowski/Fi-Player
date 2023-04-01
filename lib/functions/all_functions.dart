// ignore_for_file: avoid_print, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';
import 'package:flutter/material.dart';
import '../widget/appbar.dart';
import '../widget/drawer.dart';

ValueNotifier<List<String>> allVideosNotify = ValueNotifier([]);

ValueNotifier<List<String>> likedVideoNotify = ValueNotifier([]);

List<String> allFolders = [];

Map<String, List<String>> playlist = {};

List<String> playlistKey = [];

//for getting the name of video or folder from patch
String getVideoName(String path) {
  var temp = path.split('/');
  String name = temp.removeLast();
  return name;
}

//getting the number of folders for local folder page. it is working along with fetching process
getFoldersList(String videoPath) {
  var temp = videoPath.split('/');
  temp.removeLast();
  allFolders.add(temp.join('/'));
}

//to get videos inside the specific folder
getInnerFolderData(String folderPath) {
  var innerFolder = allVideosNotify.value
      .where((element) => element.contains(folderPath))
      .toList();
  return innerFolder;
}

//creating playlist
addplaylist(String playlistName) {
  playlist[playlistName] = [];
  playlistKey.add(playlistName);
}

//add video to the specific playlist
addVideoToPlaylist(String playlistName, String videoPath) {
  playlist[playlistName]!.add(videoPath);
}

//show dialouge playlist
Future<dynamic> showDialougeOfPlaylist(BuildContext context,
    {required int videoIndex, required List listFrom}) {
  return Future.delayed(
    Duration(seconds: 0),
    () => showDialog(
      context: context,
      builder: (context) {
        final playlistController = TextEditingController();
        return Center(
            child: SizedBox(
          height: 400,
          width: 350,
          child: Card(
            color: mainBGColor,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: playlistController,
                    // autofocus: true,
                    decoration: InputDecoration(
                        labelText: 'Playlist Name',
                        labelStyle: TextStyle(color: Colors.purple),
                        border: OutlineInputBorder()),
                    style: TextStyle(color: allTextColor),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (playlistController.text.trim() != '' &&
                            !playlistKey
                                .contains(playlistController.text.trim())) {
                          addplaylist(playlistController.text);
                        }
                        isListView.notifyListeners();
                      },
                      child: Text('add')),
                  Expanded(
                    child: ValueListenableBuilder(
                        valueListenable: isListView,
                        builder: (context, value, child) => playlist.isEmpty
                            ? Center(
                                child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.mood_bad_sharp,
                                    color: Colors.purple,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'No Playlist',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
                              ))
                            : ListView.separated(
                                // shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    onTap: () {
                                      if (!playlist[playlistKey[index]]!
                                          .contains(listFrom[videoIndex])) {
                                        playlist[playlistKey[index]]!
                                            .add(listFrom[videoIndex]);
                                        log('Successfully Added To "${playlistKey[index]}"');
                                        snackBarMessage(context,
                                            'Successfully Added To "${playlistKey[index]}"');
                                      } else {
                                        log('Already Contains');
                                        snackBarMessage(
                                            context, 'Already Contains');
                                      }
                                      Navigator.of(context).pop();
                                    },
                                    leading: Icon(
                                      Icons.playlist_play,
                                      color: Colors.purple,
                                      size: 60,
                                    ),
                                    title: Text(
                                      playlistKey[index],
                                      style: TextStyle(color: allTextColor),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return Divider(
                                    color: allTextColor,
                                  );
                                },
                                itemCount: playlist.length)),
                  )
                ],
              ),
            ),
          ),
        ));
      },
    ),
  );
}

//snackbar message
void snackBarMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..removeCurrentSnackBar()
    ..showSnackBar(SnackBar(
      content: Text(
        message,
        style: TextStyle(
            color: Colors.purple, fontSize: 18, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.purple[100],
      elevation: 5,
    ));
}
