import 'package:fi_player/screens/screen_settings/screen_settings.dart';
import 'package:fi_player/screens/splash/screen_splash.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';
import '../screens/screen_help/screen_help.dart';

bool isDarkMode = false;
Color? mainBGColor = Colors.purple[50];
Color? allTextColor = Colors.black;
Color? bottomNavColor = Colors.white;

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    super.key,
  });

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
                value: isDarkMode,
                onChanged: (value) {
                  if (isDarkMode == true) {
                    isDarkMode = false;
                    mainBGColor = Colors.purple[50];
                    allTextColor = Colors.black;
                    bottomNavColor = Colors.white;
                  } else {
                    isDarkMode = true;
                    mainBGColor = const Color.fromARGB(255, 43, 7, 48);
                    allTextColor = Colors.white;
                    bottomNavColor = Colors.black;
                  }

                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const SplashScreen(),
                      ),
                      (route) => true);
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
            onTap: () async {
              await Share.share(
                  'Check out this awesome app!\nhttps://play.google.com/store/apps/details?id=com.lebowski.fi_player');
            },
            leading: const Icon(Icons.share, color: Colors.purple),
            title: Text(
              'Share Fi Player',
              style: TextStyle(color: allTextColor),
            ),
          ),
          const SizedBox(
            height: 150,
          ),
          FutureBuilder<PackageInfo>(
            future: _getPackageInfo(),
            builder:
                (BuildContext context, AsyncSnapshot<PackageInfo> snapshot) {
              if (snapshot.hasData) {
                return Center(child: Text('Version ${snapshot.data!.version}'));
              } else {
                return const Text('');
              }
            },
          ),
        ]);
  }

  Future<PackageInfo> _getPackageInfo() async {
    return await PackageInfo.fromPlatform();
  }
}
