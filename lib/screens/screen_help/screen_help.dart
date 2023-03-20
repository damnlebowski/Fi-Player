// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import '../../widget/drawer.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBGColor,
        appBar: AppBar(
          title: Text('Help'),
        ),
        body: Center(
            child: Column(
          children: [Text('Hi'), Text('Hloo')],
        )));
  }
}
