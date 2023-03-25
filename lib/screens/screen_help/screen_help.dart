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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
                '''Welcome to the help page for our video player application. Here you will find answers to common questions and troubleshooting tips.

1. How do I play a video?
To play a video, simply tap on the "play" button in the center of the player. You can also use the spacebar on your keyboard to start and stop playback.

2. How do I adjust the volume?
You can adjust the volume by tapping on the speaker icon in the bottom right corner of the player and dragging the slider up or down. You can also use the up and down volume buttons on your mobile device to adjust the volume.

3. How do I switch to full screen mode?
To switch to full screen mode, tap on the full screen icon in the bottom right corner of the player. You can also use the "F" key on your keyboard to toggle between full screen and regular mode.

4. Why is the video not playing?
If the video is not playing, there could be several reasons. First, check your internet connection to ensure that you have a stable connection. Second, make sure that your application is up to date and compatible with the player. Finally, try clearing your application cache and reloading the page.

5. Why is the video buffering?
If the video is buffering, it could be due to a slow internet connection or a high volume of traffic on the server. Try pausing the video and allowing it to buffer for a few minutes before resuming playback.

6. How do I skip ahead or rewind?
You can skip ahead or rewind by tapping on the progress bar at the bottom of the player to the desired location. You can also use the left and right arrow buttons on your mobile device to skip ahead or rewind in small increments.

7. If you have any further questions or issues, please contact our support team at damn_lebowski@protonemail.com.''',
                style: TextStyle(
                    color: allTextColor, fontSize: 16, wordSpacing: 3)),
          ),
        ));
  }
}
