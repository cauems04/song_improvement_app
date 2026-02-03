import 'package:flutter/cupertino.dart';
import 'package:guitar_song_improvement/controller/album_controller.dart';
import 'package:guitar_song_improvement/controller/artist_controller.dart';
import 'package:guitar_song_improvement/controller/song_controller.dart';
import 'package:guitar_song_improvement/data/model/album.dart';
import 'package:guitar_song_improvement/data/model/artist.dart';
import 'package:guitar_song_improvement/data/model/song.dart';

class SongViewmodel {
  final SongController _songController;
  final AlbumController _albumController;
  final ArtistController _artistController;

  final ValueNotifier<int> _currentPage = ValueNotifier(1);

  ValueNotifier<int> get currentPage => _currentPage;
  set setCurrentPage(int pageNumber) {
    if (pageNumber != _currentPage.value) _currentPage.value = pageNumber;
  }

  SongViewmodel(
    this._songController,
    this._albumController,
    this._artistController,
  );

  void deleteCurrentSong(Song song) async {
    await _songController.delete(song);
    await _albumController.delete(Album(name: song.album));
    await _artistController.delete(Artist(name: song.artist));
  }
}
