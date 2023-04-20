import 'package:fi_player/functions/all_functions.dart';
import 'package:fi_player/screens/screen_video_playing/screen_video_playing.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import '../../model/model.dart';
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
    const LocalFolderPage(),
    const AllVideosPage(),
    const LikedVideosPage(),
    const PlaylistPage()
  ];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: isDarkMode,
        builder: (context, value, child) {
          return Scaffold(
            backgroundColor: mainBGColor,
            appBar: const PreferredSize(
                preferredSize: Size.fromHeight(70), child: AppBarWidget()),
            drawer: const SafeArea(
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
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.folder), label: 'Local'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.video_library_sharp), label: 'Videos'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.favorite), label: 'Liked'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.playlist_add_rounded), label: 'PlayList')
                ]),
          );
        });
  }

  onTapIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
