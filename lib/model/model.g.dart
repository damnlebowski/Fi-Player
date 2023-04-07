// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LikedVideoAdapter extends TypeAdapter<LikedVideo> {
  @override
  final int typeId = 0;

  @override
  LikedVideo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LikedVideo(
      video: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, LikedVideo obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.video);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LikedVideoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PlayListAdapter extends TypeAdapter<PlayList> {
  @override
  final int typeId = 1;

  @override
  PlayList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlayList(
      playlistName: fields[0] as String,
      videosList: (fields[1] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, PlayList obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.playlistName)
      ..writeByte(1)
      ..write(obj.videosList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
