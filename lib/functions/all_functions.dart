// ignore_for_file: avoid_print, prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, unused_local_variable

import 'dart:developer';
import 'package:fi_player/model/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_video_info/flutter_video_info.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:url_launcher/url_launcher.dart';
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
  playlist[playlistName]!.add('videoPath');
}

//show dialouge playlist and playlist hive
Future<dynamic> showDialougeOfPlaylist(BuildContext context,
    {required int videoIndex, required List listFrom}) {
  return Future.delayed(
    Duration(seconds: 0),
    () => showDialog(
      context: context,
      builder: (context) {
        //hive open box
        final playlistBox = Hive.box<PlayList>('playlist_video'); //hive
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
                children: [
                  TextField(
                    controller: playlistController,
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
                        //add playlist name to hive
                        if (playlistController.text.trim() != '' &&
                            !playlistKey
                                .contains(playlistController.text.trim())) {
                          final playlistModel = PlayList(
                              playlistName: playlistController.text,
                              videosList: []);
                          playlistBox.add(playlistModel); //hive
                          print('----${playlistBox.values}-----');
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
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    onTap: () {
                                      if (!playlist[playlistKey[index]]!
                                          .contains(listFrom[videoIndex])) {
                                        //add video and playlist to hive
                                        playlist[playlistKey[index]]!
                                            .add(listFrom[videoIndex]);
                                        final playlistModel = PlayList(
                                            playlistName: playlistKey[index],
                                            videosList:
                                                playlist[playlistKey[index]]!);
                                        playlistBox.putAt(
                                            index, playlistModel); //hive
                                        print('----${playlistBox.values}');
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
      duration: Duration(seconds: 1),
      content: Text(
        message,
        style: TextStyle(
            color: Colors.purple, fontSize: 18, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.purple[100],
      elevation: 5,
    ));
}

//get everthing from hive

getEverthing() async {
  final likedBox = Hive.box<LikedVideo>('liked_video');
  final playlistBox = Hive.box<PlayList>('playlist_video');
  likedVideoNotify.value.clear();
  playlist.clear();
  playlistKey.clear();

  final List<LikedVideo> likedModelList = likedBox.values.toList();
  likedVideoNotify.value =
      likedModelList.map((element) => element.video).toList();

  final List<PlayList> playlistModel = playlistBox.values.toList();
  playlistKey = playlistModel.map((element) => element.playlistName).toList();
  var listOfList = playlistModel.map((element) => element.videosList).toList();
  playlist = {
    for (var element in playlistKey)
      element: listOfList[playlistKey.indexOf(element)]
  };
}

//add Liked Videos

void addLikedVideo(
    int index, BuildContext context, List<String> fromList) async {
  if (!likedVideoNotify.value.contains(fromList[index])) {
    final likedModel = LikedVideo(video: fromList[index]);
    final likedBox = Hive.box<LikedVideo>('liked_video');
    await likedBox.add(likedModel);
    likedVideoNotify.value.add(fromList[index]);

    log('Successfully added to liked videos');
    snackBarMessage(context, 'Successfully Added To Liked Videos');
  } else {
    log('already contains');
    snackBarMessage(context, 'Already Contains');
  }
}

//remove liked videos

void removeLikedVideo(int index, BuildContext context) {
  final likedBox = Hive.box<LikedVideo>('liked_video');
  likedVideoNotify.value.removeAt(index);
  likedBox.deleteAt(index);
  isListView.notifyListeners();
  log('Removed From Liked');
  snackBarMessage(context, 'Removed From Liked');
}

//video duration

class VideoDuration extends StatelessWidget {
  VideoDuration({super.key, required this.videoPath});
  String videoPath;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: getVideoDuration(videoPath),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data!,
              style: TextStyle(
                  backgroundColor: Colors.black, color: Colors.white));
        } else {
          return Text('Error: ${snapshot.error}',
              style: TextStyle(
                  backgroundColor: Colors.black, color: Colors.white));
        }
      },
    );
  }

  Future<String> getVideoDuration(videoPath) async {
    final videoInfo = FlutterVideoInfo();
    var info = await videoInfo.getVideoInfo(videoPath);

    return convertMillisecondsToTime(info!.duration!.toInt());
  }
}

convertMillisecondsToTime(int milliseconds) {
  int seconds = (milliseconds / 1000).truncate();
  int minutes = (seconds / 60).truncate();
  int hours = (minutes / 60).truncate();

  String formattedTime =
      '${hours.toString().padLeft(2, '0')}:${(minutes % 60).toString().padLeft(2, '0')}:${(seconds % 60).toString().padLeft(2, '0')}';
  return formattedTime;
}

//delete Playlist Hive

void deletePlaylistHive(int index) {
  final playlistBox = Hive.box<PlayList>('playlist_video');
  playlist.remove(playlistKey[index]);
  playlistBox.deleteAt(index);
  playlistKey.removeAt(index);
  isListView.notifyListeners();
  print('playlist.length');
  print(playlist.length);
  print('playlistBox.length');
  print(playlistBox.length);
  print('playlistKey.length');
  print(playlistKey.length);
}

//rename playlist

void renamePlaylist(int index, BuildContext context) {
  final playlistController = TextEditingController(text: playlistKey[index]);
  Future.delayed(
    Duration(seconds: 0),
    () => showDialog(
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
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            playlistController.clear();
                            Navigator.of(context).pop();
                          },
                          child: Text('cancel')),
                      ElevatedButton(
                          onPressed: () {
                            //playlist hive rename
                            if (playlistController.text.trim() != '' &&
                                !playlistKey
                                    .contains(playlistController.text.trim())) {
                              final playlistBox =
                                  Hive.box<PlayList>('playlist_video');
                              playlist[playlistController.text] =
                                  playlist[playlistKey[index]]!;

                              playlist.remove(playlistKey[index]);

                              playlistKey[index] = playlistController.text;
                              final playlistModel = PlayList(
                                  playlistName: playlistKey[index],
                                  videosList: playlist[playlistKey[index]]!);
                              playlistBox.putAt(index, playlistModel);

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
    ),
  );
}

//join our telegram

getToTelegram() async {
  String telegramUrl = "https://t.me/fi_player";
  Uri uri = Uri.parse(telegramUrl);
  await launchUrl(uri, mode: LaunchMode.externalNonBrowserApplication);
}
