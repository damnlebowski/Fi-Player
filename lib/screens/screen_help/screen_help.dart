import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../widget/drawer.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: mainBGColor,
        appBar: AppBar(
          title: const Text('Help'),
          actions: [
            IconButton(
                onPressed: () async {
                  String? encodeQueryParameters(Map<String, String> params) {
                    return params.entries
                        .map((MapEntry<String, String> e) =>
                            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                        .join('&');
                  }

                  final Uri emailLaunchUri = Uri(
                    scheme: 'mailto',
                    path: 'damn.lebowski@protonmail.com',
                    query: encodeQueryParameters(<String, String>{
                      'subject': 'Fi Player related query',
                    }),
                  );
                  await launchUrl(emailLaunchUri);
                },
                icon: const Icon(Icons.question_answer_outlined))
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
                '''Welcome to the help page for our video player application. Here you will find answers to common questions and troubleshooting tips.

1. How do I play a video?
To play a video, simply tap on the "play" button in the center of the player.

2. How do I adjust the volume?
You can adjust the volume by tapping on the speaker icon in the bottom left corner of the player.

3. How do I switch to full screen mode?
To switch to full screen mode, tap on the full screen icon in the bottom right corner of the player.

4. Why is the video not playing?
If the video is not playing, there could be several reasons. First, check you have proper video file. Second, make sure that your application is up to date and compatible with the player. Finally, try clearing your application cache and reloading the page.

5. Why is the video buffering?
If the video is buffering, it could be due to fetching data from your mobile. Try pausing the video and allowing it to buffer for a few minutes before resuming playback.

6. How do I skip ahead or rewind?
You can skip ahead or rewind by tapping on the progress bar at the bottom of the player to the desired location.

7. If you have any further questions or issues, please contact our support team at damn.lebowski@protonmail.com''',
                style: TextStyle(
                    color: allTextColor, fontSize: 16, wordSpacing: 3)),
          ),
        ));
  }
}
