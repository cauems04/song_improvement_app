import 'package:guitar_song_improvement/controller/song_controller.dart';
import 'package:guitar_song_improvement/data/model/album.dart';
import 'package:guitar_song_improvement/data/model/artist.dart';
import 'package:guitar_song_improvement/data/model/song.dart';

class ArtistViewmodel {
  late final Artist artist;

  final SongController _songController;

  ArtistViewmodel(this._songController);

  void initValues(Artist artist) {
    this.artist = artist;
  }

  Future<({List<Song> songs, List<Album> album})> getData() async {
    List<Song> songs = await _songController.getSongsByArtist(artist);

    List<Album> albums = songs
        .map((song) => Album(name: song.album))
        .toSet()
        .toList();
    return (songs: songs, album: albums);
  }

  String get getInitials => artist.name
      .trim()
      .split(" ")
      .where((text) => text.isNotEmpty)
      .take(2)
      .map((text) => text[0])
      .join()
      .toUpperCase();
}
