import 'package:bloc/bloc.dart';
import 'package:fi_player/functions/all_functions.dart';
import 'package:meta/meta.dart';

part 'playlist_inner_videos_event.dart';
part 'playlist_inner_videos_state.dart';

class PlaylistInnerVideosBloc
    extends Bloc<PlaylistInnerVideosEvent, PlaylistInnerVideosState> {
  PlaylistInnerVideosBloc()
      : super(PlaylistInnerVideosInitial(playlist: [])) {
    on<RemoveVideo>((event, emit) {
      List<String> tempList;
      tempList = playlist[event.playlistName]!;
      tempList.removeAt(event.index);
      return emit(PlaylistInnerVideosState(playlist: tempList));
    });
  }
}
