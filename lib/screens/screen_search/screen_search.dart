// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import '../../functions/all_functions.dart';
import '../../widget/drawer.dart';
import '../screen_video_playing/screen_video_playing.dart';

class SearchPage extends StatefulWidget {
  SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();

  List<String> searchList = List<String>.from(allVideosNotify.value);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBGColor,
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  searchList = allVideosNotify.value
                      .where((element) => getVideoName(element)
                          .toLowerCase()
                          .contains(value.toLowerCase()))
                      .toList();
                });
              },
              controller: searchController,
              autofocus: true,
              decoration: InputDecoration(
                  labelText: 'Search',
                  labelStyle: TextStyle(color: Colors.purple),
                  border: OutlineInputBorder()),
              style: TextStyle(color: allTextColor),
            ),
            SizedBox(height: 10),
            Expanded(
                child: searchList.isEmpty
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
                            'There Is No Videos',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ))
                    : ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return ListTile(
                            //liked and playlist
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => VideoPlayingPage(
                                        videoPath: searchList[index],
                                        fromList: searchList,
                                        curentIndex: index,
                                      )));
                            },
                            leading: SizedBox(
                              height: 60,
                              width: 80,
                              child: ColoredBox(color: Colors.blue),
                            ),
                            title: Text(
                              getVideoName(searchList[index]),
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
                                          .contains(searchList[index])) {
                                        likedVideoNotify.value
                                            .add(searchList[index]);
                                        log('Successfully added to liked videos');
                                        snackBarMessage(context,
                                            'Successfully Added To Liked Videos');
                                      } else {
                                        log('already contains');
                                        snackBarMessage(
                                            context, 'Already Contains');
                                      }
                                      // likedVideoNotify.notifyListeners();
                                    }),
                                PopupMenuItem(
                                  child: Text('Add to Playlist',
                                      style: TextStyle(color: allTextColor)),
                                  onTap: () {
                                    showDialougeOfPlaylist(context,
                                        videoIndex: index,
                                        listFrom: searchList);
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
                        itemCount: searchList.length))
          ],
        ),
      ),
    );
  }
}
