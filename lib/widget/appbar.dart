// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class AppBarWidget extends StatefulWidget {
  const AppBarWidget({super.key});

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

bool isListView = true;

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      // leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
      title: Text('FI Player'),
      actions: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
                onPressed: () {
                  setState(() {
                    if (isListView == true) {
                      isListView = false;
                    } else {
                      isListView = true;
                    }
                  });
                },
                icon: isListView == true
                    ? Icon(Icons.grid_view_sharp)
                    : Icon(Icons.format_list_numbered_sharp)),
            IconButton(onPressed: () {}, icon: Icon(Icons.search)),
            PopupMenuButton(
              itemBuilder: (context) => [PopupMenuItem(child: Text('Refersh'))],
            )
          ],
        ),
      ],
    );
  }
}
