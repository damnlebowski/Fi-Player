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

@HiveType(typeId: 2)
class PlayedHistory extends HiveObject {
  @HiveField(0)
  final String video;

  @HiveField(1)
  final int position;

  @HiveField(2)
  final int duration;

  PlayedHistory(
      {required this.video, required this.position, required this.duration});
}

@HiveType(typeId: 3)
class LastPlayed extends HiveObject {
  @HiveField(0)
  final String video;

  @HiveField(1)
  final int position;

  LastPlayed({required this.video, required this.position});
}
