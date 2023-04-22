import 'package:fi_player/functions/all_functions.dart';
import 'package:fi_player/screens/screen_privacy_policy/screen_privacy_policy.dart';
import 'package:fi_player/screens/screen_terms_and_condition/screen_terms_and_condition.dart';
import 'package:flutter/material.dart';
import '../../widget/drawer.dart';

class StettingsScreen extends StatelessWidget {
  const StettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBGColor,
      appBar: AppBar(),
      body: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.rotate_left, color: Colors.purple),
            title:
                Text('Reset Fi Player', style: TextStyle(color: allTextColor)),
            onTap: () {
              resetDialog(context, 0);
            },
          ),
          ListTile(
            leading: const Icon(Icons.telegram, color: Colors.purple),
            title: Text('Join Our Telegram Channel',
                style: TextStyle(color: allTextColor)),
            onTap: () => getToTelegram(),
          ),
          ListTile(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const PrivacyPolicy(),
            )),
            leading: const Icon(Icons.gpp_maybe_outlined, color: Colors.purple),
            title:
                Text('Privacy Policy', style: TextStyle(color: allTextColor)),
          ),
          ListTile(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => TermsAndConditionsPage(),
            )),
            leading: const Icon(Icons.check_box_outlined, color: Colors.purple),
            title: Text('Terms And Conditions',
                style: TextStyle(color: allTextColor)),
          ),
          ListTile(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) =>
                    // AlertDialog(
                    //       backgroundColor: mainBGColor,
                    //       content: Row(
                    //         children: [
                    //           SizedBox(
                    //               height: 70,
                    //               width: 70,
                    //               child: ClipRRect(
                    //                   borderRadius: BorderRadius.circular(5),
                    //                   child:
                    //                       Image.asset('assets/FI_PLAYER.png'))),
                    //           SizedBox(
                    //             width: 25,
                    //           ),
                    //           Text(
                    //             'Fi Player',
                    //             style:
                    //                 TextStyle(color: allTextColor, fontSize: 20),
                    //           )
                    //         ],
                    //       ),
                    //       actions: [
                    //         TextButton(
                    //             onPressed: () => null, child: Text('CLOSE'))
                    //       ],
                    //     )
                    const AboutDialog(
                        applicationIcon: FlutterLogo(),
                        applicationLegalese: 'legallese',
                        applicationName: 'Fi Player',
                        applicationVersion: '2.0.0'),
              );
            },
            leading: const Icon(Icons.info_outline, color: Colors.purple),
            title: Text('About', style: TextStyle(color: allTextColor)),
          )
        ],
      ),
    );
  }

  resetDialog(BuildContext context, index) {
    showDialog(
        context: context,
        builder: ((ctx) => AlertDialog(
              backgroundColor: mainBGColor,
              content: Text(
                maxLines: 2,
                'Are you sure? You will lost all Liked and Playlist videos.',
                style: TextStyle(fontSize: 18, color: allTextColor),
              ),
              actions: [
                TextButton(
                    onPressed: () => Navigator.of(context).pop(ctx),
                    child: const Text(
                      'No',
                      style: TextStyle(fontSize: 20),
                    )),
                TextButton(
                  onPressed: () {
                    resetEverthing();
                    Navigator.of(context).pop(ctx);
                  },
                  child: const Text(
                    'Yes',
                    style: TextStyle(fontSize: 20),
                  ),
                )
              ],
            )));
  }
}
