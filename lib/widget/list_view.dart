// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'dart:developer';
import 'package:fi_player/screens/screen_arranged_video_folder/screen_arranged_video_folder.dart';
import 'package:fi_player/screens/screen_inner_playlist/screen_inner_playlist.dart';
import 'package:fi_player/screens/screen_local_folder/screen_local_folder.dart';
import 'package:fi_player/screens/screen_video_playing/screen_video_playing.dart';
import 'package:fi_player/widget/appbar.dart';
import 'package:flutter/material.dart';
import '../functions/all_functions.dart';
import 'drawer.dart';

//all videos section list view widget
class ListViewWidgetForAllVideos extends StatelessWidget {
  ListViewWidgetForAllVideos({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return ListTile(
            //liked and playlist
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => VideoPlayingPage(
                      videoPath: allVideosNotify.value[index])));
            },
            leading: SizedBox(
              height: 60,
              width: 80,
              child: ColoredBox(color: Colors.blue),
            ),
            title: Text(
              getVideoName(allVideosNotify.value[index]),
              style: TextStyle(color: allTextColor),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: PopupMenuButton(
              icon: Icon(
                Icons.more_vert,
                color: Colors.grey,
              ),
              color: mainBGColor,
              itemBuilder: (context) => [
                PopupMenuItem(
                    child: Text('Add to liked videos',
                        style: TextStyle(color: allTextColor)),
                    onTap: () {
                      if (!likedVideoNotify.value
                          .contains(allVideosNotify.value[index])) {
                        likedVideoNotify.value
                            .add(allVideosNotify.value[index]);
                        log('Successfully added to liked videos');
                        snackBarMessage(
                            context, 'Successfully Added To Liked Videos');
                      } else {
                        log('already contains');
                        snackBarMessage(context, 'Already Contains');
                      }
                      // likedVideoNotify.notifyListeners();
                    }),
                PopupMenuItem(
                  child: Text('Add to Playlist',
                      style: TextStyle(color: allTextColor)),
                  onTap: () {
                    showDialougeOfPlaylist(context,
                        videoIndex: index, listFrom: allVideosNotify.value);
                  },
                )
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            color: allTextColor,
          );
        },
        itemCount: allVideosNotify.value.length);
  }
}

//all folders section list view widget
class ListViewWidgetForFolders extends StatelessWidget {
  ListViewWidgetForFolders({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    FolderInnerPage(folderAddress: allFolders[index]),
              ));
            },
            leading: Icon(
              Icons.folder_rounded,
              size: 70,
              color: Colors.purple,
            ),
            title: Text(
              getVideoName(allFolders[index]),
              style: TextStyle(color: allTextColor),
              // maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            color: allTextColor,
          );
        },
        itemCount: allFolders.length);
  }
}

//inner folders section list view widget
class ListViewWidgetForInnerVideos extends StatelessWidget {
  ListViewWidgetForInnerVideos({super.key, required this.innerFolderData});

  List<String> innerFolderData;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return ListTile(
            //liked and playlist
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      VideoPlayingPage(videoPath: innerFolderData[index])));
            },
            leading: SizedBox(
              height: 60,
              width: 80,
              child: ColoredBox(color: Colors.blue),
            ),
            title: Text(
              getVideoName(innerFolderData[index]),
              style: TextStyle(color: allTextColor),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: PopupMenuButton(
              icon: Icon(
                Icons.more_vert,
                color: Colors.grey,
              ),
              color: mainBGColor,
              itemBuilder: (context) => [
                PopupMenuItem(
                    child: Text('Add to liked videos',
                        style: TextStyle(color: allTextColor)),
                    onTap: () {
                      if (!likedVideoNotify.value
                          .contains(innerFolderData[index])) {
                        likedVideoNotify.value.add(innerFolderData[index]);
                        log('Successfully added to liked videos');
                        snackBarMessage(
                            context, 'Successfully Added To Liked Videos');
                      } else {
                        log('already contains');
                        snackBarMessage(context, 'Already Contains');
                      }
                      // likedVideoNotify.notifyListeners();
                    }),
                PopupMenuItem(
                  child: Text('Add to Playlist',
                      style: TextStyle(color: allTextColor)),
                  onTap: () {
                    showDialougeOfPlaylist(context,
                        videoIndex: index, listFrom: innerFolderData);
                  },
                )
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            color: allTextColor,
          );
        },
        itemCount: innerFolderData.length);
  }
}

//liked videos section list view widget
class ListViewWidgetForLikedVideos extends StatelessWidget {
  ListViewWidgetForLikedVideos({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => VideoPlayingPage(
                      videoPath: likedVideoNotify.value[index])));
            },
            leading: SizedBox(
              height: 60,
              width: 80,
              child: ColoredBox(color: Colors.blue),
            ),
            title: Text(
              getVideoName(likedVideoNotify.value[index]),
              style: TextStyle(color: allTextColor),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: PopupMenuButton(
              icon: Icon(
                Icons.more_vert,
                color: Colors.grey,
              ),
              color: mainBGColor,
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: Text('Remove liked videos',
                      style: TextStyle(color: allTextColor)),
                  onTap: () {
                    likedVideoNotify.value
                        .remove(likedVideoNotify.value[index]);
                    isListView.notifyListeners();
                    log('Removed From Liked');
                    snackBarMessage(context, 'Removed From Liked');
                  },
                ),
                PopupMenuItem(
                  child: Text('Add to Playlist',
                      style: TextStyle(color: allTextColor)),
                  onTap: () {
                    showDialougeOfPlaylist(context,
                        videoIndex: index, listFrom: likedVideoNotify.value);
                  },
                )
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            color: allTextColor,
          );
        },
        itemCount: likedVideoNotify.value.length);
  }
}

//playlist section list view widget
class ListViewWidgetForPlaylist extends StatelessWidget {
  ListViewWidgetForPlaylist({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PlaylistInsidePage(
                        playlistName: playlistKey[index],
                      )));
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
            trailing: PopupMenuButton(
              icon: Icon(
                Icons.more_vert,
                color: Colors.grey,
              ),
              color: mainBGColor,
              itemBuilder: (context) => [
                PopupMenuItem(
                    child: Text('Rename Playlist',
                        style: TextStyle(color: allTextColor)),
                    onTap: () {
                      // if (!likedVideoNotify.value
                      //     .contains(allVideosNotify.value[index])) {
                      //   likedVideoNotify.value
                      //       .add(allVideosNotify.value[index]);
                      //   log('Successfully added to liked videos');
                      // } else {
                      //   log('already contains');
                      // }
                      // // likedVideoNotify.notifyListeners();
                    }),
                PopupMenuItem(
                  child: Text('Delete Playlist',
                      style: TextStyle(color: allTextColor)),
                  onTap: () {
                    log('Playlist "${playlistKey[index]}" Deleted');
                    snackBarMessage(context, 'Removed "${playlistKey[index]}"');
                    playlist.remove(playlistKey[index]);
                    playlistKey.removeAt(index);
                    isListView.notifyListeners();
                  },
                )
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            color: allTextColor,
          );
        },
        itemCount: playlist.length);
  }
}

//inner playlist section list view widget
class ListViewWidgetForInnerPlaylist extends StatelessWidget {
  ListViewWidgetForInnerPlaylist({super.key, required this.playlistName});

  String playlistName;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return ListTile(
            //liked and playlist
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => VideoPlayingPage(
                      videoPath: playlist[playlistName]![index])));
            },
            leading: SizedBox(
              height: 60,
              width: 80,
              child: ColoredBox(color: Colors.blue),
            ),
            title: Text(
              getVideoName(playlist[playlistName]![index]),
              style: TextStyle(color: allTextColor),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: PopupMenuButton(
              icon: Icon(
                Icons.more_vert,
                color: Colors.grey,
              ),
              color: mainBGColor,
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: Text(
                    'Remove From Playlist',
                    style: TextStyle(color: allTextColor),
                  ),
                  onTap: () {
                    log('Song Removed From "$playlistName"');
                    snackBarMessage(
                        context, 'Song Removed From "$playlistName"');
                    playlist[playlistName]!.removeAt(index);
                    isListView.notifyListeners();
                  },
                )
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            color: allTextColor,
          );
        },
        itemCount: playlist[playlistName]?.length ?? 0);
  }
}
