// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../../widget/drawer.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBGColor,
      appBar: AppBar(title: Text('About')),
      body: Center(
        child: Text('About'),
      ),
    );
  }
}