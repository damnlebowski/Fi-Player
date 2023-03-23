// ignore_for_file: prefer_const_constructors, must_be_immutable
import 'package:fi_player/screens/screen_video_playing/screen_video_playing.dart';
import 'package:flutter/material.dart';
import '../functions/all_functions.dart';
import 'drawer.dart';

class GridViewWidget extends StatelessWidget {
  GridViewWidget(
      {super.key,
      required this.title,
      required this.nextPage,
      required this.icon});

  IconData icon;
  Widget nextPage;
  String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GridView.builder(
        itemCount: 25,
        physics: BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10),
        itemBuilder: (context, index) {
          return InkWell(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => nextPage));
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    size: 50,
                    color: Colors.purple,
                  ),
                  Text(
                    '$title Name $index',
                    style: TextStyle(color: allTextColor),
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ));
        },
      ),
    );
  }
}

class GridViewWidgetForVideos extends StatelessWidget {
  GridViewWidgetForVideos({super.key});

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
                children: [
                  Icon(
                    Icons.video_file_outlined,
                    size: 50,
                    color: Colors.purple,
                  ),
                  Text(
                    allVideosNotify.value[index],
                    style: TextStyle(color: allTextColor),
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ));
        },
      ),
    );
  }
}
