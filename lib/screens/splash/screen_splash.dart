// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, annotate_overrides

import 'package:flutter/material.dart';
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
    // ignore: todo
    // TODO: implement initState
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
    await Future.delayed(Duration(seconds: 3));
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => NavbarPage(),
    ));
  }
}
