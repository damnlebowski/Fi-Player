import 'dart:developer';
import 'package:fi_player/model/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_video_info/flutter_video_info.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:url_launcher/url_launcher.dart';
import '../screens/screen_video_playing/screen_video_playing.dart';
import '../widget/appbar.dart';
import '../widget/drawer.dart';

ValueNotifier<List<String>> allVideosNotify = ValueNotifier([]);

ValueNotifier<List<String>> likedVideoNotify = ValueNotifier([]);

List<String> allFolders = [];

Map<String, List<String>> playlist = {};

List<String> playlistKey = [];

ValueNotifier<List<String>> playedHistoryListNotifier = ValueNotifier([]);

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

//show dialouge add playlist and playlist hive
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
          height: MediaQuery.of(context).size.height * .50,
          width: MediaQuery.of(context).size.height * .40,
          child: Card(
            color: mainBGColor,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  TextField(
                    controller: playlistController,
                    decoration: const InputDecoration(
                        labelText: 'Playlist Name',
                        labelStyle: TextStyle(color: Colors.purple),
                        border: OutlineInputBorder()),
                    style: TextStyle(color: allTextColor),
                  ),
                  const SizedBox(
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
                          addplaylist(playlistController.text);

                          isListView.notifyListeners();
                        }
                      },
                      child: const Text('add')),
                  Expanded(
                    child: ValueListenableBuilder(
                        valueListenable: isListView,
                        builder: (context, value, child) => playlist.isEmpty
                            ? Center(
                                child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.mood_bad_sharp,
                                    color: Colors.purple,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'No Playlist',
                                    style: TextStyle(
                                        fontSize: 20, color: allTextColor),
                                  ),
                                ],
                              ))
                            : ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    tileColor: Colors.purple[100],
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
                                    leading: const Icon(
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
      width: 240,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 1),
      content: Center(
        child: Text(
          message,
          style: const TextStyle(
              color: Colors.purple, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Colors.purple[100],
      elevation: 5,
    ));
}

//get everthing from hive

getEverthing() async {
  final likedBox = Hive.box<LikedVideo>('liked_video');
  final playlistBox = Hive.box<PlayList>('playlist_video');
  final playedHistoryBox = Hive.box<PlayedHistory>('played_history');
  likedVideoNotify.value.clear();
  playlist.clear();
  playlistKey.clear();
  playedHistoryListNotifier.value.clear();

//get liked videos
  final List<LikedVideo> likedModelList = likedBox.values.toList();
  likedVideoNotify.value =
      likedModelList.map((element) => element.video).toList();

//get play list
  final List<PlayList> playlistModel = playlistBox.values.toList();
  playlistKey = playlistModel.map((element) => element.playlistName).toList();
  var listOfList = playlistModel.map((element) => element.videosList).toList();
  playlist = {
    for (var element in playlistKey)
      element: listOfList[playlistKey.indexOf(element)]
  };

  //get played history
  final List<PlayedHistory> playedHistoryModelList =
      playedHistoryBox.values.toList();
  playedHistoryListNotifier.value =
      playedHistoryModelList.map((element) => element.video).toList();
}

//reset all
resetEverthing() async {
  final likedBox = Hive.box<LikedVideo>('liked_video');
  final playlistBox = Hive.box<PlayList>('playlist_video');
  final lastPlayedBox = Hive.box<LastPlayed>('last_played');
  final playedHistoryBox = Hive.box<PlayedHistory>('played_history');
  likedBox.clear();
  playlistBox.clear();
  lastPlayedBox.clear();
  playedHistoryBox.clear();
  likedVideoNotify.value.clear();
  playlist.clear();
  playlistKey.clear();
  playedHistoryListNotifier.value.clear();
  isListView.notifyListeners();
  likedVideoNotify.notifyListeners();
}

//add Liked Videos

void addLikedVideo(BuildContext context, String video) async {
  if (!likedVideoNotify.value.contains(video)) {
    final likedModel = LikedVideo(video: video);
    final likedBox = Hive.box<LikedVideo>('liked_video');
    await likedBox.add(likedModel);
    likedVideoNotify.value.add(video);

    log('Successfully added to liked videos');
    snackBarMessage(context, 'Successfully Added To Liked Videos');
    likedVideoNotify.notifyListeners();

    return;
  } else {
    log('already contains');
    snackBarMessage(context, 'Already Contains');
    return;
  }
}

//remove liked videos

void removeLikedVideo(int index, BuildContext context) {
  final likedBox = Hive.box<LikedVideo>('liked_video');
  likedVideoNotify.value.removeAt(index);
  likedBox.deleteAt(index);
  likedVideoNotify.notifyListeners();
  log('Removed From Liked');
  snackBarMessage(context, 'Removed From Liked');
  return;
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
              style: const TextStyle(
                  backgroundColor: Colors.black,
                  color: Colors.white,
                  fontSize: 12));
        } else {
          return Text('Error: ${snapshot.error}',
              style: const TextStyle(
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

  String hourText = '${hours.toString().padLeft(2, '')}:';
  if (hours == 0) {
    hourText = '';
  }

  String formattedTime =
      '$hourText${(minutes % 60).toString().padLeft(2, '0')}:${(seconds % 60).toString().padLeft(2, '0')}';
  return formattedTime;
}

//delete Playlist Hive

void deletePlaylistHive(int index) {
  final playlistBox = Hive.box<PlayList>('playlist_video');
  playlist.remove(playlistKey[index]);
  playlistBox.deleteAt(index);
  playlistKey.removeAt(index);
  isListView.notifyListeners();
}

//delete a video from playlist

void deleteVideoFromPlaylist(int index, String playlistName) {
  final playlistBox = Hive.box<PlayList>('playlist_video');
  List<String> videoList = [];
  videoList.addAll(playlistBox.values
      .elementAt(playlistKey.indexOf(playlistName))
      .videosList);
  videoList.removeAt(index);
  PlayList playlistModel =
      PlayList(playlistName: playlistName, videosList: videoList);
  playlistBox.putAt(playlistKey.indexOf(playlistName), playlistModel);
  playlist[playlistName]!.removeAt(index);
  isListView.notifyListeners();
}

//rename playlist

void renamePlaylist(int index, BuildContext context) {
  final playlistController = TextEditingController(text: playlistKey[index]);
  Future.delayed(
    const Duration(seconds: 0),
    () => showDialog(
      context: context,
      builder: (context) {
        return Center(
            child: SizedBox(
          height: MediaQuery.of(context).size.height * .25,
          width: MediaQuery.of(context).size.height * .40,
          child: Card(
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
                  ),
                  const SizedBox(
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
                          child: const Text('cancel')),
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
                          child: const Text('add')),
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

//add to played history
addToPlayedHistory(String video, int position, int durstion) async {
  final playedHistoryBox = Hive.box<PlayedHistory>('played_history');
  final playedHistoryModel =
      PlayedHistory(video: video, position: position, duration: durstion);
  if (playedHistoryListNotifier.value.contains(video)) {
    playedHistoryBox.deleteAt(playedHistoryListNotifier.value.indexOf(video));
    playedHistoryListNotifier.value.remove(video);
  }
  playedHistoryBox.add(playedHistoryModel);
  playedHistoryListNotifier.value.add(video);
  SchedulerBinding.instance.addPostFrameCallback((_) {
    playedHistoryListNotifier.notifyListeners();
  });
}

//resume button
class ResumeButton extends StatelessWidget {
  const ResumeButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        final lastPlayedBox = Hive.box<LastPlayed>('last_played');
        if (lastPlayedBox.isNotEmpty) {
          LastPlayed lastPlayedModel = lastPlayedBox.values.first;
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => VideoPlayingPage(
                  index: 0,
                  fromList: [lastPlayedModel.video],
                  seekFrom: lastPlayedModel.position)));
        } else {
          snackBarMessage(context, 'No Videos Played Yet.');
        }
      },
      child: const Icon(
        Icons.play_circle_outline,
        size: 35,
      ),
    );
  }
}
