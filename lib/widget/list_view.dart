// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';

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
              overflow: TextOverflow.ellipsis,
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
        itemCount: 15);
  }
}

class ListViewWidgetForVideos extends StatelessWidget {
  ListViewWidgetForVideos(
      {super.key, required this.title, required this.nextPage});
  String title;
  Widget nextPage;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return ListTile(
            onLongPress: () {},
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => nextPage));
            },
            leading: Icon(
              Icons.video_file_outlined,
              size: 50,
              color: Colors.purple,
            ),
            title: Text(
              '$title Name $index',
              overflow: TextOverflow.ellipsis,
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
        itemCount: 15);
  }
}
