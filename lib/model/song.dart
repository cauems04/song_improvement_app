import 'package:guitar_song_improvement/model/i_model.dart';

class Song implements IModel {
  final String name;
  final String artist;
  final String album;
  final String? image;

  const Song({
    required this.name,
    required this.artist,
    required this.album,
    this.image,
  });

  Song.fromJson(
    Map<String, dynamic> json,
  ) // Tentar mudar de dynamic pra object para melhor performance
  : name = json["trackName"].toString(),
      artist = json["artistName"].toString(),
      album = json["collectionName"].toString(),
      image = json["artworkUrl60"].toString();

  Map<String, String> toMap() {
    return {};
  }
}
