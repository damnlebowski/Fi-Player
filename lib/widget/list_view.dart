import 'dart:developer';
import 'package:fi_player/functions/thumbnail_fetching.dart';
import 'package:fi_player/screens/screen_arranged_video_folder/screen_arranged_video_folder.dart';
import 'package:fi_player/screens/screen_inner_playlist/screen_inner_playlist.dart';
import 'package:fi_player/screens/screen_video_playing/screen_video_playing.dart';
import 'package:fi_player/widget/appbar.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import '../functions/all_functions.dart';
import '../model/model.dart';
import 'drawer.dart';

//all videos section list view widget
class ListViewWidgetForAllVideos extends StatelessWidget {
  const ListViewWidgetForAllVideos({super.key});

  @override
  Widget build(BuildContext context) {
    return allVideosNotify.value.isEmpty
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
                'There Is No Videos',
                style: TextStyle(fontSize: 20, color: allTextColor),
              ),
            ],
          ))
        : ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => VideoPlayingPage(
                            fromList: allVideosNotify.value,
                            index: index,
                            seekFrom: 0,
                          )));
                },
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(7),
                  child: Stack(
                    children: [
                      Container(
                        color: Colors.black,
                        height: 95,
                        width: 100,
                        child: ThumbnailWidget(
                            videoPath: allVideosNotify.value[index]),
                      ),
                      Positioned(
                          bottom: 5,
                          right: 5,
                          child: VideoDuration(
                            videoPath: allVideosNotify.value[index],
                          ))
                    ],
                  ),
                ),
                title: Text(
                  getVideoName(allVideosNotify.value[index]),
                  style: TextStyle(color: allTextColor),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: PopupMenuButton(
                  icon: const Icon(
                    Icons.more_vert,
                    color: Colors.grey,
                  ),
                  color: mainBGColor,
                  itemBuilder: (context) => [
                    PopupMenuItem(
                        child: Text('Add to liked videos',
                            style: TextStyle(color: allTextColor)),
                        onTap: () {
                          addLikedVideo(context, allVideosNotify.value[index]);
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
  const ListViewWidgetForFolders({super.key});

  @override
  Widget build(BuildContext context) {
    return allFolders.isEmpty
        ? Center(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  [
            const  Icon(
                Icons.mood_bad_sharp,
                color: Colors.purple,
              ),
            const  SizedBox(
                height: 10,
              ),
              Text(
                'No Folders',
                style: TextStyle(fontSize: 20,color: allTextColor),
              ),
            ],
          ))
        : ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        FolderInnerPage(folderAddress: allFolders[index]),
                  ));
                },
                leading: const Icon(
                  Icons.folder_rounded,
                  size: 70,
                  color: Colors.purple,
                ),
                title: Text(
                  getVideoName(allFolders[index]),
                  style: TextStyle(color: allTextColor),
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
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return ListTile(
            //liked and playlist
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => VideoPlayingPage(
                        fromList: innerFolderData,
                        index: index,
                        seekFrom: 0,
                      )));
            },
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(7),
              child: Stack(
                children: [
                  Container(
                    color: Colors.black,
                    height: 95,
                    width: 100,
                    child: ThumbnailWidget(videoPath: innerFolderData[index]),
                  ),
                  Positioned(
                      bottom: 5,
                      right: 5,
                      child: VideoDuration(
                        videoPath: innerFolderData[index],
                      ))
                ],
              ),
            ),
            title: Text(
              getVideoName(innerFolderData[index]),
              style: TextStyle(color: allTextColor),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: PopupMenuButton(
              icon: const Icon(
                Icons.more_vert,
                color: Colors.grey,
              ),
              color: mainBGColor,
              itemBuilder: (context) => [
                PopupMenuItem(
                    child: Text('Add to liked videos',
                        style: TextStyle(color: allTextColor)),
                    onTap: () {
                      addLikedVideo(context, innerFolderData[index]);
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
  const ListViewWidgetForLikedVideos({super.key});

  @override
  Widget build(BuildContext context) {
    return likedVideoNotify.value.isEmpty
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
                'No Liked Videos Yet',
                style: TextStyle(fontSize: 20, color: allTextColor),
              ),
            ],
          ))
        : ValueListenableBuilder(
            valueListenable: likedVideoNotify,
            builder: (context, values, child) => ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => VideoPlayingPage(
                                fromList: values,
                                index: index,
                                seekFrom: 0,
                              )));
                    },
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(7),
                      child: Stack(
                        children: [
                          Container(
                            color: Colors.black,
                            height: 95,
                            width: 100,
                            child: ThumbnailWidget(videoPath: values[index]),
                          ),
                          Positioned(
                              bottom: 5,
                              right: 5,
                              child: VideoDuration(
                                videoPath: values[index],
                              ))
                        ],
                      ),
                    ),
                    title: Text(
                      getVideoName(values[index]),
                      style: TextStyle(color: allTextColor),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: PopupMenuButton(
                      icon: const Icon(
                        Icons.more_vert,
                        color: Colors.grey,
                      ),
                      color: mainBGColor,
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          child: Text('Remove liked videos',
                              style: TextStyle(color: allTextColor)),
                          onTap: () {
                            removeLikedVideo(index, context);
                          },
                        ),
                        PopupMenuItem(
                          child: Text('Add to Playlist',
                              style: TextStyle(color: allTextColor)),
                          onTap: () {
                            showDialougeOfPlaylist(context,
                                videoIndex: index, listFrom: values);
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
                itemCount: values.length),
          );
  }
}

//playlist section list view widget
class ListViewWidgetForPlaylist extends StatelessWidget {
  const ListViewWidgetForPlaylist({super.key});

  @override
  Widget build(BuildContext context) {
    //.........................................................................................
    return playlistKey.isEmpty
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
                'Playlist Is Empty',
                style: TextStyle(fontSize: 20, color: allTextColor),
              ),
            ],
          ))
        : ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PlaylistInsidePage(
                            playlistIndex: index,
                          )));
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
                trailing: PopupMenuButton(
                  icon: const Icon(
                    Icons.more_vert,
                    color: Colors.grey,
                  ),
                  color: mainBGColor,
                  itemBuilder: (context) => [
                    PopupMenuItem(
                        child: Text('Rename Playlist',
                            style: TextStyle(color: allTextColor)),
                        onTap: () {
                          renamePlaylist(index, context);
                        }),
                    PopupMenuItem(
                      child: Text('Delete Playlist',
                          style: TextStyle(color: allTextColor)),
                      onTap: () {
                        snackBarMessage(
                            context, 'Removed "${playlistKey[index]}"');
                        log('Playlist "${playlistKey[index]}" Deleted');
                        deletePlaylistHive(index);
                        // isListView.notifyListeners();
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
            itemCount: playlistKey.length);
  }
}

//inner playlist section list view widget
class ListViewWidgetForInnerPlaylist extends StatelessWidget {
  ListViewWidgetForInnerPlaylist({super.key, required this.fromPlaylistName});

  String fromPlaylistName;
  @override
  Widget build(BuildContext context) {
    return playlist[fromPlaylistName]!.isEmpty
        ? Center(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.mood_bad_sharp,
                color: Colors.purple,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'No Videos In This Playlist',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ))
        : ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return ListTile(
                //liked and playlist
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => VideoPlayingPage(
                            fromList: playlist[fromPlaylistName]!,
                            index: index,
                            seekFrom: 0,
                          )));
                },
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(7),
                  child: Stack(
                    children: [
                      Container(
                        color: Colors.black,
                        height: 95,
                        width: 100,
                        child: ThumbnailWidget(
                            videoPath: playlist[fromPlaylistName]![index]),
                      ),
                      Positioned(
                          bottom: 5,
                          right: 5,
                          child: VideoDuration(
                            videoPath: playlist[fromPlaylistName]![index],
                          ))
                    ],
                  ),
                ),
                title: Text(
                  getVideoName(playlist[fromPlaylistName]![index]),
                  style: TextStyle(color: allTextColor),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: PopupMenuButton(
                  icon: const Icon(
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
                        log('video Removed From "$fromPlaylistName"');
                        snackBarMessage(
                            context, 'video Removed From "$fromPlaylistName"');

                        deleteVideoFromPlaylist(index, fromPlaylistName);
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
            itemCount: playlist[fromPlaylistName]?.length ?? 0);
  }
}
