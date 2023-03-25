// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:fi_player/widget/list_view.dart';
import 'package:flutter/material.dart';
import '../../widget/drawer.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

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
            TextFieldSearch(),
            SizedBox(height: 10),
            Expanded(child: ListViewWidgetForAllVideos())
          ],
        ),
      ),
    );
  }
}

class TextFieldSearch extends StatelessWidget {
  const TextFieldSearch({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: true,
      decoration: InputDecoration(
          labelText: 'Search', labelStyle: TextStyle(color: Colors.purple)),
      style: TextStyle(color: allTextColor),
    );
  }
}
