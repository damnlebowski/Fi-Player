// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';

class GridViewWidget extends StatelessWidget {
  GridViewWidget(
      {super.key,
      required this.title,
      required this.nextPage,
      required this.icon});
  String title;
  Widget nextPage;
  IconData icon;
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
  GridViewWidgetForVideos(
      {super.key, required this.title, required this.nextPage});
  String title;
  Widget nextPage;
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
              onLongPress: () {},
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => nextPage));
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
                    '$title Name $index',
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ));
        },
      ),
    );
  }
}
