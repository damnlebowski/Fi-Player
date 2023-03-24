// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';

import '../screens/screen_arranged_video_folder/screen_arranged_video_folder.dart';
import '../screens/screen_local_folder/screen_local_folder.dart';

ValueNotifier<List<String>> allVideosNotify = ValueNotifier([]);

ValueNotifier<List> likedVideoNotify = ValueNotifier([]);

ValueNotifier<List> innerFolderVideoNotify = ValueNotifier([]);

String getVideoName(String path) {
  var temp = path.split('/');
  String name = temp.removeLast();
  return name;
}

getFoldersList(String videoPath) {
  var temp = videoPath.split('/');
  temp.removeLast();
  allFolders.add(temp.join('/'));
}

getInnerFolderData(String folderPath) {
  var innerFolder= allVideosNotify.value
      .where((element) => element.contains(folderPath))
      .toList();
  return innerFolder;
}
