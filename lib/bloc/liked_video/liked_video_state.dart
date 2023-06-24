part of 'liked_video_bloc.dart';

class LikedVideoState {
  final List<String> likedVideos;

  LikedVideoState({required this.likedVideos});
}

class LikedVideoInitial extends LikedVideoState {
  LikedVideoInitial({required super.likedVideos});
}
