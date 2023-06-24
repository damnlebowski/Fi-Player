import 'dart:developer';

import 'package:fi_player/bloc/search_page/search_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../functions/all_functions.dart';
import '../../functions/thumbnail_fetching.dart';
import '../../widget/drawer.dart';
import '../screen_video_playing/screen_video_playing.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key});

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SearchPageBloc>(context).add(SearchTextChanged(''));
    return Scaffold(
      backgroundColor: mainBGColor,
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                BlocProvider.of<SearchPageBloc>(context)
                    .add(SearchTextChanged(value));
              },
              controller: searchController,
              autofocus: true,
              decoration: const InputDecoration(
                  labelText: 'Search',
                  labelStyle: TextStyle(color: Colors.purple),
                  border: OutlineInputBorder()),
              style: TextStyle(color: allTextColor),
            ),
            const SizedBox(height: 10),
            Expanded(child: BlocBuilder<SearchPageBloc, SearchPageState>(
              builder: (context, state) {
                log('$state');
                return state.results.isEmpty
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
                            //liked and playlist
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => VideoPlayingPage(
                                        fromList: state.results,
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
                                        videoPath: state.results[index]),
                                  ),
                                  Positioned(
                                      bottom: 5,
                                      right: 5,
                                      child: VideoDuration(
                                        videoPath: state.results[index],
                                      ))
                                ],
                              ),
                            ),
                            title: Text(
                              getVideoName(state.results[index]),
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
                                          context, state.results[index]);
                                    }),
                                PopupMenuItem(
                                  child: Text('Add to Playlist',
                                      style: TextStyle(color: allTextColor)),
                                  onTap: () {
                                    showDialougeOfPlaylist(context,
                                        videoIndex: index,
                                        listFrom: state.results);
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
                        itemCount: state.results.length);
              },
            ))
          ],
        ),
      ),
    );
  }
}
