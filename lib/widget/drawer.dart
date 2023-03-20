// ignore_for_file: prefer_const_constructors

import 'package:fi_player/screens/screen_settings/screen_settings.dart';
import 'package:flutter/material.dart';

import '../screens/screen_help/screen_help.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
        backgroundColor: Colors.purple[50],
        elevation: 5,
        children: [
          Container(
            height: 70,
            color: Colors.purple,
          ),
          SizedBox(
            height: 200,
            child: Image.asset('assets/FI_PLAYER.png'),
          ),
          SizedBox(height: 20),
          ListTile(
            leading: Icon(Icons.dark_mode_outlined, color: Colors.purple),
            title: Text('Dark Theme'),
            trailing: Switch(value: false, onChanged: (value) {}),
          ),
          ListTile(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => StettingsScreen(),
            )),
            leading: Icon(Icons.settings_applications, color: Colors.purple),
            title: Text('Settings'),
          ),
          ListTile(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => HelpScreen(),
            )),
            leading: Icon(Icons.help_center_outlined, color: Colors.purple),
            title: Text('Help'),
          ),
        ]);
  }
}
