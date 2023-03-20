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
            leading: Icon(Icons.telegram, color: Colors.purple),
            title: Text('Join Our Telegram Channel'),
          ),
          ListTile(
            leading: Icon(Icons.facebook, color: Colors.purple),
            title: Text('Join Our Facebook Channel'),
          ),
          ListTile(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => PrivacyPolicy(),
            )),
            leading: Icon(Icons.gpp_maybe_outlined, color: Colors.purple),
            title: Text('Privacy Policy'),
          ),
          ListTile(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AboutScreen(),
            )),
            leading: Icon(Icons.info_outline, color: Colors.purple),
            title: Text('About'),
          )
        ],
      ),
    );
  }
}
