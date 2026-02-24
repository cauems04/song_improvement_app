import 'package:guitar_song_improvement/data/model/i_model.dart';
import 'package:guitar_song_improvement/data/local/database/database_manager.dart';

class Song implements IModel {
  final int? id;
  final String _name;
  final int timesPlayed;
  // Maybe in the future will need to pass Albums/Artists classes to songs, so it can have their covers for example, or to treat the values easily, for example, songController is fixing album and artist names (and it doesn't look cool being there).
  final String artist;
  final String album;
  final String? image;

  @override
  String get name => _name;

  // double get reducedScore => score / 100;

  const Song({
    required String name,
    required this.artist,
    required this.album,
    this.id,
    this.timesPlayed = 0,
    this.image,
  }) : _name = name;

  Song.fromJson(
    Map<String, dynamic> json,
  ) // Tentar mudar de dynamic pra object para melhor performance
  : id = null,
      timesPlayed = 0,
      _name = json["trackName"].toString(),
      artist = json["artistName"].toString(),
      album = json["collectionName"].toString(),
      image = json["artworkUrl60"].toString();

  Song.fromDbJson(
    Map<String, dynamic> json,
  ) // Tentar mudar de dynamic pra object para melhor performance
  : id = json[DatabaseManager.songIdLabel],
      _name = json[DatabaseManager.songNameLabel].toString(),
      timesPlayed = json[DatabaseManager.songTimesPlayedLabel],
      artist = json[DatabaseManager.songArtistLabel].toString(),
      album = json[DatabaseManager.songAlbumLabel].toString(),
      image = null;

  @override
  Map<String, String> toMap() {
    return {
      DatabaseManager.songNameLabel: name,
      DatabaseManager.songArtistLabel: artist,
      DatabaseManager.songAlbumLabel: album,
    };
  }
}
