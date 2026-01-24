import 'package:guitar_song_improvement/controller/album_controller.dart';
import 'package:guitar_song_improvement/controller/artist_controller.dart';
import 'package:guitar_song_improvement/controller/song_controller.dart';
import 'package:guitar_song_improvement/data/model/song.dart';

class HomeViewmodel {
  final SongController _songController;
  final AlbumController _albumController;
  final ArtistController _artistController;

  HomeViewmodel({
    required SongController songController,
    required AlbumController albumController,
    required ArtistController artistController,
  }) : _songController = songController,
       _albumController = albumController,
       _artistController = artistController;

  Future<List<Song>> get getAllSongs async => await _songController.readAll();
}
