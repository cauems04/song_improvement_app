import 'package:guitar_song_improvement/model/i_model.dart';

class Song implements IModel {
  final String _name;
  final String artist;
  final String album;
  final String? image;

  @override
  String get name => _name;

  const Song({
    required String name,
    required this.artist,
    required this.album,
    this.image,
  }) : _name = name;

  Song.fromJson(
    Map<String, dynamic> json,
  ) // Tentar mudar de dynamic pra object para melhor performance
  : _name = json["trackName"].toString(),
      artist = json["artistName"].toString(),
      album = json["collectionName"].toString(),
      image = json["artworkUrl60"].toString();

  Song.fromDbJson(
    Map<String, dynamic> json,
  ) // Tentar mudar de dynamic pra object para melhor performance
  : _name = json["title"].toString(),
      artist = json["artist_name"].toString(),
      album = json["album_title"].toString(),
      image = null;

  Map<String, String> toMap() {
    return {"title": name, "artist_name": artist, "album_title": album};
  }
}
