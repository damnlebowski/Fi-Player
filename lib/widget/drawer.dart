import 'package:fi_player/screens/screen_history.dart';
import 'package:fi_player/screens/screen_settings/screen_settings.dart';
import 'package:fi_player/widget/appbar.dart';
import 'package:flutter/material.dart';
import '../screens/screen_help/screen_help.dart';

ValueNotifier<bool> isDarkMode = ValueNotifier(false);
Color? mainBGColor = Colors.purple[50];
Color? allTextColor = Colors.black;
Color? bottomNavColor = Colors.white;

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({
    super.key,
  });

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
        backgroundColor: mainBGColor,
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
          const SizedBox(height: 20),
          ListTile(
            leading: const Icon(Icons.dark_mode_outlined, color: Colors.purple),
            title: Text(
              'Dark Theme',
              style: TextStyle(color: allTextColor),
            ),
            trailing: Switch(
                value: isDarkMode.value,
                onChanged: (value) {
                  setState(() {
                    if (isDarkMode.value == true) {
                      isDarkMode.value = false;
                      mainBGColor = Colors.purple[50];
                      allTextColor = Colors.black;
                      bottomNavColor = Colors.white;
                    } else {
                      isDarkMode.value = true;
                      mainBGColor = const Color.fromARGB(255, 43, 7, 48);
                      allTextColor = Colors.white;
                      bottomNavColor = Colors.black;
                    }
                    isListView.notifyListeners();
                  });
                }),
          ),
          ListTile(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const StettingsScreen(),
            )),
            leading:
                const Icon(Icons.settings_applications, color: Colors.purple),
            title: Text(
              'Settings',
              style: TextStyle(color: allTextColor),
            ),
          ),
          ListTile(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const HelpScreen(),
            )),
            leading:
                const Icon(Icons.help_center_outlined, color: Colors.purple),
            title: Text(
              'Help',
              style: TextStyle(color: allTextColor),
            ),
          ),
          ListTile(
            onTap: () async {},
            leading: const Icon(Icons.share, color: Colors.purple),
            title: Text(
              'Share Fi Player',
              style: TextStyle(color: allTextColor),
            ),
          )
        ]);
  }
}
