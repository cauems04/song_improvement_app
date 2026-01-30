import 'package:flutter/cupertino.dart';
import 'package:guitar_song_improvement/controller/album_controller.dart';
import 'package:guitar_song_improvement/controller/artist_controller.dart';
import 'package:guitar_song_improvement/controller/song_controller.dart';
import 'package:guitar_song_improvement/data/model/album.dart';
import 'package:guitar_song_improvement/data/model/artist.dart';
import 'package:guitar_song_improvement/data/model/song.dart';

class SongViewmodel {
  final SongController songController;
  final AlbumController albumController;
  final ArtistController artistController;

  final ValueNotifier<int> _currentPage = ValueNotifier(1);

  ValueNotifier<int> get currentPage => _currentPage;
  set setCurrentPage(int pageNumber) {
    if (pageNumber != _currentPage.value) _currentPage.value = pageNumber;
  }

  SongViewmodel(
    this.songController,
    this.albumController,
    this.artistController,
  );

  void deleteCurrentSong(Song song) async {
    await songController.delete(song);
    await albumController.delete(Album(name: song.album));
    await artistController.delete(Artist(name: song.artist));
  }
}
