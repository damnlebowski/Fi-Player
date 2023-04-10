import 'package:hive_flutter/hive_flutter.dart';
part 'model.g.dart';

@HiveType(typeId: 0)
class LikedVideo {
  @HiveField(0)
  final String video;

  LikedVideo({required this.video});
}

@HiveType(typeId: 1)
class PlayList extends HiveObject {
  @HiveField(0)
  final String playlistName;
  @HiveField(1)
  final List<String> videosList;

  PlayList({required this.playlistName, required this.videosList});
}

@HiveType(typeId: 3)
class LastPlayed extends HiveObject {
  @HiveField(0)
  final String video;

  @HiveField(1)
  final int position;

  LastPlayed({required this.video, required this.position});
}

// @HiveType(typeId: 4)
// class IsDarkMode extends HiveObject {
//   @HiveField(0)
//   final bool isDarkMode;

//   IsDarkMode({required this.isDarkMode});
// }
