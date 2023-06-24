part of 'liked_video_bloc.dart';

@immutable
abstract class LikedVideoEvent {}

class AddLikedVideo extends LikedVideoEvent {
  final String videoPath;

  AddLikedVideo({required this.videoPath});
}

class RemoveLikedVideo extends LikedVideoEvent {
  final String videoPath;

  RemoveLikedVideo({required this.videoPath});
}
