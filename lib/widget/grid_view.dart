// ignore_for_file: prefer_const_constructors, must_be_immutable, avoid_print
import 'dart:developer';

import 'package:fi_player/screens/screen_arranged_video_folder/screen_arranged_video_folder.dart';
import 'package:fi_player/screens/screen_local_folder/screen_local_folder.dart';
import 'package:fi_player/screens/screen_video_playing/screen_video_playing.dart';
import 'package:fi_player/widget/appbar.dart';
import 'package:flutter/material.dart';
import '../functions/all_functions.dart';
import 'drawer.dart';

//all videos section list view widget
class GridViewWidgetForAllVideos extends StatelessWidget {
  GridViewWidgetForAllVideos({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GridView.builder(
        itemCount: allVideosNotify.value.length,
        physics: BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
        itemBuilder: (context, index) {
          return InkWell(
              //liked and playlist
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => VideoPlayingPage(
                        videoPath: allVideosNotify.value[index])));
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 80,
                    width: 130,
                    child: ColoredBox(color: Colors.blue),
                  ),
                  ListTile(
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
                            } else {
                              log('already contains');
                            }
                          },
                        ),
                        PopupMenuItem(
                          child: Text('Add to Playlist',
                              style: TextStyle(color: allTextColor)),
                          onTap: () {
                            print(likedVideoNotify.value);
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
        physics: BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
        itemBuilder: (context, index) {
          return InkWell(
              //liked and playlist
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        VideoPlayingPage(videoPath: innerFolderData[index])));
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 80,
                    width: 130,
                    child: ColoredBox(color: Colors.blue),
                  ),
                  ListTile(
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
                              likedVideoNotify.value
                                  .add(innerFolderData[index]);
                              log('Successfully added to liked videos');
                            } else {
                              log('already contains');
                            }
                          },
                        ),
                        PopupMenuItem(
                          child: Text('Add to Playlist',
                              style: TextStyle(color: allTextColor)),
                          onTap: () {
                            print(likedVideoNotify.value);
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
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GridView.builder(
        itemCount: allFolders.length,
        physics: BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10),
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
                  Icon(
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
                  // ListTile(
                  //   title: Text(
                  //     getVideoName(allFolders[index]),
                  //     style: TextStyle(color: allTextColor),
                  //     maxLines: 2,
                  //     overflow: TextOverflow.ellipsis,
                  //   ),
                  //   trailing: PopupMenuButton(
                  //     icon: Icon(
                  //       Icons.more_vert,
                  //       color: Colors.grey,
                  //     ),
                  //     color: mainBGColor,
                  //     itemBuilder: (context) => [
                  //       PopupMenuItem(
                  //         child: Text('Add to liked videos',
                  //             style: TextStyle(color: allTextColor)),
                  //         onTap: () {
                  //           if (!likedVideoNotify.value
                  //               .contains(allVideosNotify.value[index])) {
                  //             likedVideoNotify.value
                  //                 .add(allVideosNotify.value[index]);
                  //             log('Successfully added to liked videos');
                  //           } else {
                  //             log('already contains');
                  //           }
                  //         },
                  //       ),
                  //       PopupMenuItem(
                  //         child: Text('Add to Playlist',
                  //             style: TextStyle(color: allTextColor)),
                  //         onTap: () {
                  //           print(likedVideoNotify.value);
                  //         },
                  //       )
                  //     ],
                  //   ),
                  // )
                ],
              ));
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
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GridView.builder(
        itemCount: likedVideoNotify.value.length,
        physics: BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
        itemBuilder: (context, index) {
          return InkWell(
              //liked and playlist
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => VideoPlayingPage(
                        videoPath: likedVideoNotify.value[index])));
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 80,
                    width: 130,
                    child: ColoredBox(color: Colors.blue),
                  ),
                  ListTile(
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
                          child: Text('Remove from liked videos',
                              style: TextStyle(color: allTextColor)),
                          onTap: () {
                            likedVideoNotify.value
                                .remove(likedVideoNotify.value[index]);
                            // likedVideoNotify.notifyListeners();
                            isListView.notifyListeners();
                          },
                        ),
                        PopupMenuItem(
                          child: Text('Add to Playlist',
                              style: TextStyle(color: allTextColor)),
                          onTap: () {
                            print(likedVideoNotify.value);
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
