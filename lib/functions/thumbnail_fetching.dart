
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class ThumbnailWidget extends StatelessWidget {
  ThumbnailWidget({super.key, required this.videoPath});
  String videoPath;
  String? img;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: getThumbnail('/$videoPath'),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        return snapshot.hasData
            ? Image.file(
                File(snapshot.data!),
                fit: BoxFit.contain,
              )
            : const Padding(
                padding: EdgeInsets.fromLTRB(25, 15, 25, 15),
                child: Center(
                  child: Text(
                    'Loading...',
                    style: TextStyle(color: Colors.white, fontSize: 11),
                  ),
                ),
              );
      },
    );
  }

  Future<String> getThumbnail(String video) async {
    final String? fileName = await VideoThumbnail.thumbnailFile(
      video: video,
      thumbnailPath: (await getTemporaryDirectory()).path,
      quality: 100,
    );
    return fileName!;
  }
}
