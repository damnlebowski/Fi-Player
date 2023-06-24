import 'package:flutter/material.dart';
import '../../functions/all_functions.dart';
import '../../functions/video_fetching.dart';
import '../../widget/drawer.dart';
import '../screen_navbar_home/screen_navbar_home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
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
    FetchAllVideos ob = FetchAllVideos();
    List<String> allVideos = await ob.getAllVideos();
    allVideosList.addAll(allVideos);

    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => MyWidget(),
    ));
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return NavbarPage();
  }
}
