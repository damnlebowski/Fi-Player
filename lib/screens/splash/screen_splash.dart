import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../functions/all_functions.dart';
import '../../widget/drawer.dart';
import '../screen_navbar_home/screen_navbar_home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static const MethodChannel _platform =
      MethodChannel('com.lebowski/video_files/search');

  @override
  void initState() {
    super.initState();
    wait();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBGColor,
      body: Center(child: Image.asset('assets/FI_PLAYER.png')),
    );
  }

  wait() async {
    await Future.delayed(const Duration(seconds: 1));
    List<String> allVideos = await searchInStorage();
    allVideosList.addAll(allVideos);
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => NavbarPage(),
    ));
  }

  Future<List<String>> searchInStorage() async {
    var status = await Permission.storage.request();

    if (status.isGranted) {
      List<String>? videoList =
          await _SplashScreenState._platform.invokeListMethod('search');
      if (videoList != null) {
        for (var video in videoList) {
          //checking and creating the folder
          getFoldersList(video);
        }
      }

      return videoList ?? [];
    } else {
      return [];
    }
  }
}
