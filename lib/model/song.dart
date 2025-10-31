import 'package:guitar_song_improvement/model/i_model.dart';

class Song implements IModel {
  final int? id;
  final String _name;
  // Maybe in the future will need to pass Albums/Artists classes to songs, so it can have their covers for example, or to treat the values easily, for example, songController is fixing album and artist names (and it doesn't look cool being there).
  final String artist;
  final String album;
  final String? image;

  @override
  String get name => _name;

  const Song({
    required String name,
    required this.artist,
    required this.album,
    this.id,
    this.image,
  }) : _name = name;

  Song.fromJson(
    Map<String, dynamic> json,
  ) // Tentar mudar de dynamic pra object para melhor performance
  : id = null,
      _name = json["trackName"].toString(),
      artist = json["artistName"].toString(),
      album = json["collectionName"].toString(),
      image = json["artworkUrl60"].toString();

  Song.fromDbJson(
    Map<String, dynamic> json,
  ) // Tentar mudar de dynamic pra object para melhor performance
  : id = json["id"],
      _name = json["title"].toString(),
      artist = json["artist_name"].toString(),
      album = json["album_title"].toString(),
      image = null;

  Map<String, String> toMap() {
    return {"title": name, "artist_name": artist, "album_title": album};
  }
}
