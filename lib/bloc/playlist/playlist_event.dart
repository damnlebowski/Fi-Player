part of 'playlist_bloc.dart';

@immutable
abstract class PlaylistEvent {}

class AddPlaylist extends PlaylistEvent {
  final String playlistName;

  AddPlaylist({required this.playlistName});
}

class RemovePlaylist extends PlaylistEvent {
  final int index;

  RemovePlaylist({required this.index});
}

class RenamePlaylist extends PlaylistEvent {
  final String playlistName;
  final int index;

  RenamePlaylist({required this.playlistName, required this.index});
}
