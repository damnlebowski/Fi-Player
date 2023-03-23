import 'dart:developer';
import 'dart:io';
// import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'dart:async';

// void main() async {
// WidgetsFlutterBinding.ensureInitialized();
// FetchAllVideos ob = FetchAllVideos();
// List videos = await ob.getAllVideos();
// log("videos.lenght ${videos.length}");
// }

// class FetchAllVideos {
List videosDirectories = [];
List myDirectories = [];
int myIndex = 0;

Future<List> getAllVideos() async {
  log("fetching");

  var status = await Permission.storage.request();
  if (status.isGranted) {
    myDirectories.clear();
    videosDirectories.clear();

    List<Directory>? extDir = await getExternalStorageDirectories();
    List pathForCheck = [];

    for (var paths in extDir!) {
      String path = paths.toString();
      String actualPath = path.substring(13, path.length - 1);
      int found = 0;
      int startIndex = 0;
      for (int pathIndex = actualPath.length - 1; pathIndex >= 0; pathIndex--) {
        if (actualPath[pathIndex] == "/") {
          found++;
          if (found == 4) {
            startIndex = pathIndex;
            break;
          }
        }
      }
      var splitPath = actualPath.substring(0, startIndex + 1);
      pathForCheck.add(splitPath);
    }
    for (var pForCheck in pathForCheck) {
      Directory directory = Directory(pForCheck);
      if (directory.statSync().type == FileSystemEntityType.directory) {
        var initialDirectories = directory.listSync().map((e) {
          return e.path;
        }).toList();

        for (var directories in initialDirectories) {
          if (directories.toString().endsWith('.mp4')) {
            log("FETCHING : $directories");
            videosDirectories.add("$directories/");
          }
          if (!directories.toString().contains('.')) {
            String dirs = "$directories/";
            myDirectories.add(dirs);
          }
        }
      }
    }
  }
  for (myIndex = 0; myIndex < myDirectories.length; myIndex++) {
    var myDirs = Directory(myDirectories[myIndex]);
    if (myDirs.statSync().type == FileSystemEntityType.directory) {
      if (!myDirs.toString().contains('Android')) {
        var initialDirectories = myDirs.listSync().map((e) {
          return e.path;
        }).toList();
        for (var video in initialDirectories) {
          if (video.toString().endsWith('.mp4')) {
            log("FETCHING : $video");
            videosDirectories.add(video);
          }
        }
        for (var directories in initialDirectories) {
          if (!directories.toString().contains('.') &&
              !directories.toString().contains('android') &&
              !directories.toString().contains('Android')) {
            String dirs = "$directories/";
            var tempDir = Directory(dirs);
            if (!tempDir.toString().contains('.') &&
                !tempDir.toString().contains('android') &&
                !tempDir.toString().contains('Android')) {
              myDirectories.add(directories);
            }

            if (tempDir.statSync().type == FileSystemEntityType.directory) {
              if (!tempDir.toString().contains('/Android')) {
                var videoDirs = tempDir.listSync().map((e) {
                  return e.path;
                }).toList();

                for (var video in videoDirs) {
                  if (video.toString().endsWith('.mp4')) {
                    log("FETCHING : $video");
                    videosDirectories.add(video);
                  }
                }
              }
            }
          }
        }
      }
    }
  }
  return videosDirectories;
}
// }



// <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />