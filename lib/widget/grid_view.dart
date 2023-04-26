import 'dart:developer';
import 'package:fi_player/screens/screen_arranged_video_folder/screen_arranged_video_folder.dart';
import 'package:fi_player/screens/screen_video_playing/screen_video_playing.dart';
import 'package:fi_player/widget/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../functions/all_functions.dart';
import '../functions/thumbnail_fetching.dart';
import '../screens/screen_inner_playlist/screen_inner_playlist.dart';
import 'drawer.dart';

//all videos section list view widget
class GridViewWidgetForAllVideos extends StatelessWidget {
  GridViewWidgetForAllVideos({super.key});

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
        : Padding(
            padding: const EdgeInsets.all(10),
            child: GridView.builder(
              itemCount: allVideosNotify.value.length,
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200),

              //  const SliverGridDelegateWithFixedCrossAxisCount(
              //     crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
              itemBuilder: (context, index) {
                return InkWell(
                    //liked and playlist
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => VideoPlayingPage(
                                fromList: allVideosNotify.value,
                                index: index,
                                seekFrom: 0,
                              )));
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(7),
                          child: Stack(
                            children: [
                              Container(
                                color: Colors.black,
                                height: 95,
                                width: 150,
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
                        ListTile(
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
                                  addLikedVideo(
                                      context, allVideosNotify.value[index]);
                                },
                              ),
                              PopupMenuItem(
                                child: Text('Add to Playlist',
                                    style: TextStyle(color: allTextColor)),
                                onTap: () {
                                  showDialougeOfPlaylist(context,
                                      videoIndex: index,
                                      listFrom: allVideosNotify.value);
                                },
                              )
                            ],
                          ),
                        )
                      ],
                    ));
              },
            ),
          );
  }
}

//inner videos section list view widget
class GridViewWidgetForInnerVideos extends StatelessWidget {
  GridViewWidgetForInnerVideos({super.key, required this.innerFolderData});

  List<String> innerFolderData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GridView.builder(
        itemCount: innerFolderData.length,
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200),
        //  const SliverGridDelegateWithFixedCrossAxisCount(
        //     crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
        itemBuilder: (context, index) {
          return InkWell(
              //liked and playlist
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => VideoPlayingPage(
                          fromList: innerFolderData,
                          index: index,
                          seekFrom: 0,
                        )));
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(7),
                    child: Stack(
                      children: [
                        Container(
                          color: Colors.black,
                          height: 95,
                          width: 150,
                          child: ThumbnailWidget(
                              videoPath: innerFolderData[index]),
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
                  ListTile(
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
                          },
                        ),
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
                  )
                ],
              ));
        },
      ),
    );
  }
}

//all folders section list view widget
class GridViewWidgetForFolders extends StatelessWidget {
  GridViewWidgetForFolders({super.key});

  @override
  Widget build(BuildContext context) {
    return allFolders.isEmpty
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
                'No Folders',
                style: TextStyle(fontSize: 20, color: allTextColor),
              ),
            ],
          ))
        : Padding(
            padding: const EdgeInsets.all(10),
            child: GridView.builder(
              itemCount: allFolders.length,
              physics: const BouncingScrollPhysics(),
              // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              //     crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 150),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          FolderInnerPage(folderAddress: allFolders[index]),
                    ));
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.folder_rounded,
                        size: 70,
                        color: Colors.purple,
                      ),
                      Text(
                        getVideoName(allFolders[index]),
                        style: TextStyle(color: allTextColor),
                        // maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                );
              },
            ),
          );
  }
}

//liked videos section list view widget
class GridViewWidgetForLikedVideos extends StatelessWidget {
  GridViewWidgetForLikedVideos({super.key});

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
        : Padding(
            padding: const EdgeInsets.all(10),
            child: GridView.builder(
              itemCount: likedVideoNotify.value.length,
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200),
              // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              //     crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
              itemBuilder: (context, index) {
                return InkWell(
                    //liked and playlist
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => VideoPlayingPage(
                                fromList: likedVideoNotify.value,
                                index: index,
                                seekFrom: 0,
                              )));
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(7),
                          child: Stack(
                            children: [
                              Container(
                                color: Colors.black,
                                height: 95,
                                width: 150,
                                child: ThumbnailWidget(
                                    videoPath: likedVideoNotify.value[index]),
                              ),
                              Positioned(
                                  bottom: 5,
                                  right: 5,
                                  child: VideoDuration(
                                    videoPath: likedVideoNotify.value[index],
                                  ))
                            ],
                          ),
                        ),
                        ListTile(
                          title: Text(
                            getVideoName(likedVideoNotify.value[index]),
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
                                child: Text('Remove from liked videos',
                                    style: TextStyle(color: allTextColor)),
                                onTap: () {
                                  likedVideoNotify.value
                                      .remove(likedVideoNotify.value[index]);
                                  isListView.notifyListeners();
                                },
                              ),
                              PopupMenuItem(
                                child: Text('Add to Playlist',
                                    style: TextStyle(color: allTextColor)),
                                onTap: () {
                                  showDialougeOfPlaylist(context,
                                      videoIndex: index,
                                      listFrom: likedVideoNotify.value);
                                },
                              )
                            ],
                          ),
                        )
                      ],
                    ));
              },
            ),
          );
  }
}

//playlist section list view widget
class GridViewWidgetForPlaylist extends StatelessWidget {
  //................................................................
  const GridViewWidgetForPlaylist({super.key});

  @override
  Widget build(BuildContext context) {
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
        : Padding(
            padding: const EdgeInsets.all(10),
            child: GridView.builder(
              itemCount: playlistKey.length,
              physics: const BouncingScrollPhysics(),
              // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              //     crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200),
              itemBuilder: (context, index) {
                return InkWell(
                    //liked and playlist
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PlaylistInsidePage(
                                playlistIndex: index,
                              )));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color.fromARGB(255, 197, 195, 195))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.playlist_play,
                            color: Colors.purple,
                            size: 60,
                          ),
                          Row(
                            children: [
                              const SizedBox(
                                width: 15,
                              ),
                              Text(
                                playlistKey[index],
                                style: TextStyle(color: allTextColor),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const Spacer(),
                              PopupMenuButton(
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
                                    },
                                  ),
                                  PopupMenuItem(
                                    child: Text('Delete Playlist',
                                        style: TextStyle(color: allTextColor)),
                                    onTap: () {
                                      snackBarMessage(context,
                                          'Playlist "${playlistKey[index]}" Deleted');
                                      log('Removed "${playlistKey[index]}"');
                                      deletePlaylistHive(index);
                                    },
                                  )
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ));
              },
            ),
          );
  }
}

//inner playlist section list view widget
class GridViewWidgetForInnerPlaylist extends StatelessWidget {
  GridViewWidgetForInnerPlaylist({super.key, required this.fromPlaylistName});
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
        : Padding(
            padding: const EdgeInsets.all(10),
            child: GridView.builder(
              itemCount: playlist[fromPlaylistName]?.length ?? 0,
              physics: const BouncingScrollPhysics(),
              // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              //     crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200),
              itemBuilder: (context, index) {
                return InkWell(
                    //liked and playlist
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => VideoPlayingPage(
                                fromList: playlist[fromPlaylistName]!,
                                index: index,
                                seekFrom: 0,
                              )));
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(7),
                          child: Stack(
                            children: [
                              Container(
                                color: Colors.black,
                                height: 95,
                                width: 150,
                                child: ThumbnailWidget(
                                    videoPath:
                                        playlist[fromPlaylistName]![index]),
                              ),
                              Positioned(
                                  bottom: 5,
                                  right: 5,
                                  child: VideoDuration(
                                    videoPath:
                                        playlist[fromPlaylistName]![index],
                                  ))
                            ],
                          ),
                        ),
                        ListTile(
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
                                  log('Song Removed From "$fromPlaylistName"');
                                  snackBarMessage(context,
                                      'Song Removed From "$fromPlaylistName"');
                                  deleteVideoFromPlaylist(
                                      index, fromPlaylistName);
                                },
                              )
                            ],
                          ),
                        )
                      ],
                    ));
              },
            ),
          );
  }
}
