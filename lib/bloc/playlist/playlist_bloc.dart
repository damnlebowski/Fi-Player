import 'package:bloc/bloc.dart';
import 'package:fi_player/functions/all_functions.dart';
import 'package:meta/meta.dart';

part 'playlist_event.dart';
part 'playlist_state.dart';

class PlaylistBloc extends Bloc<PlaylistEvent, PlaylistState> {
  PlaylistBloc() : super(PlaylistInitial(playlistKey: playlistKey)) {
    on<AddPlaylist>((event, emit) {
      playlist[event.playlistName] = [];
      playlistKey.add(event.playlistName);
      return emit(PlaylistState(playlistKey: playlistKey));
    });

    on<RemovePlaylist>((event, emit) {
      playlistKey.removeAt(event.index);
      return emit(PlaylistState(playlistKey: playlistKey));
    });

    on<RenamePlaylist>((event, emit) {
      playlist[event.playlistName] = playlist[playlistKey[event.index]]!;
      playlist.remove(playlistKey[event.index]);
      playlistKey[event.index] = event.playlistName;
      return emit(PlaylistState(playlistKey: playlistKey));
    });
  }
}
