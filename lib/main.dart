import 'package:fi_player/screens/splash/screen_splash.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.purple),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}