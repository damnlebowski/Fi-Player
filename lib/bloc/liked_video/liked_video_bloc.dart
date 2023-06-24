import 'package:bloc/bloc.dart';
import 'package:fi_player/functions/all_functions.dart';
import 'package:meta/meta.dart';

part 'liked_video_event.dart';
part 'liked_video_state.dart';

class LikedVideoBloc extends Bloc<LikedVideoEvent, LikedVideoState> {
  LikedVideoBloc() : super(LikedVideoInitial(likedVideos: likedVideoList)) {
    on<AddLikedVideo>((event, emit) {
      likedVideoList.add(event.videoPath);
      return emit(LikedVideoState(likedVideos: likedVideoList));
    });

    on<RemoveLikedVideo>((event, emit) {
      likedVideoList.remove(event.videoPath);
      return emit(LikedVideoState(likedVideos: likedVideoList));
    });
  }
}
