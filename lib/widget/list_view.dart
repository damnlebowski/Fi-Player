// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'dart:developer';

import 'package:fi_player/screens/screen_video_playing/screen_video_playing.dart';
import 'package:flutter/material.dart';

import '../functions/all_functions.dart';
import 'drawer.dart';

class ListViewWidget extends StatelessWidget {
  ListViewWidget(
      {super.key,
      required this.title,
      required this.nextPage,
      required this.icon});
  String title;
  Widget nextPage;
  IconData icon;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => nextPage));
            },
            leading: Icon(
              icon,
              size: 50,
              color: Colors.purple,
            ),
            title: Text(
              '$title Name $index',
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
        itemCount: 15);
  }
}

class ListViewWidgetForVideos extends StatelessWidget {
  ListViewWidgetForVideos({super.key, required this.notifier});

  ValueNotifier notifier;

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
                      VideoPlayingPage(videoPath: notifier.value[index])));
            },
            leading: Icon(
              Icons.video_file_outlined,
              size: 50,
              color: Colors.purple,
            ),
            title: Text(
              notifier.value[index],
              style: TextStyle(color: allTextColor),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                    child: Text('Add to liked videos'),
                    onTap: () {
                      if (!likedVideoNotify.value
                          .contains(allVideosNotify.value[index])) {
                        likedVideoNotify.value
                            .add(allVideosNotify.value[index]);
                        log('Successfully added to liked videos');
                      } else {
                        log('already contains');
                      }
                      // likedVideoNotify.notifyListeners();
                    }),
                PopupMenuItem(child: Text('Add to Playlist'))
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            color: allTextColor,
          );
        },
        itemCount: notifier.value.length);
  }
}
