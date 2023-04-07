// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_final_fields, must_be_immutable, prefer_const_constructors_in_immutables
import 'package:fi_player/functions/all_functions.dart';
import 'package:flutter/material.dart';
import '../../widget/appbar.dart';
import '../../widget/drawer.dart';
import '../screen_all_videos/screen_all_videos.dart';
import '../screen_liked_videos/screen_liked_videos.dart';
import '../screen_local_folder/screen_local_folder.dart';
import '../screen_playlist_videos/screen_playlist_videos.dart';

class NavbarPage extends StatefulWidget {
  NavbarPage({super.key});

  @override
  State<NavbarPage> createState() => _NavbarPageState();
}

class _NavbarPageState extends State<NavbarPage> {
  int _selectedIndex = 0;

  List page = [
    LocalFolderPage(),
    AllVideosPage(),
    LikedVideosPage(),
    PlaylistPage()
  ];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: isDarkMode,
        builder: (context, value, child) {
          return Scaffold(
            backgroundColor: mainBGColor,
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(70), child: AppBarWidget()),
            drawer: SafeArea(
              child: DrawerWidget(),
            ),
            body: page.elementAt(_selectedIndex),
            bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                backgroundColor: bottomNavColor,
                selectedItemColor: Colors.purple,
                unselectedItemColor: Colors.grey,
                showUnselectedLabels: true,
                currentIndex: _selectedIndex,
                onTap: onTapIndex,
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.folder), label: 'Local'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.video_library_sharp), label: 'Videos'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.favorite), label: 'Liked'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.playlist_add_rounded), label: 'PlayList')
                ]),
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              child: Icon(
                Icons.play_circle_outline,
                size: 35,
              ),
            ),
          );
        });
  }

  onTapIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
