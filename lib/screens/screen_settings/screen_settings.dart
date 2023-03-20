// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:fi_player/screens/screen_about/screen_about.dart';
import 'package:fi_player/screens/screen_privacy_policy/screen_privacy_policy.dart';
import 'package:flutter/material.dart';

class StettingsScreen extends StatelessWidget {
  const StettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[50],
      appBar: AppBar(),
      body: Column(
        children: [
          ListTile(
            leading: Icon(
              Icons.telegram,
              color: Colors.blue[700],
            ),
            title: Text('Join Our Telegram Channel'),
          ),
          ListTile(
            leading: Icon(
              Icons.facebook,
              color: Colors.blue[700],
            ),
            title: Text('Join Our Facebook Channel'),
          ),
          ListTile(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => PrivacyPolicy(),
            )),
            leading: Icon(Icons.gpp_maybe_rounded),
            title: Text('Privacy Policy'),
          ),
          ListTile(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AboutScreen(),
            )),
            leading: Icon(Icons.gpp_maybe_rounded),
            title: Text('About'),
          )
        ],
      ),
    );
  }
}
