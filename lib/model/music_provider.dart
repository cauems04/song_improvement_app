import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/controller/album_controller.dart';
import 'package:guitar_song_improvement/controller/artist_controller.dart';
import 'package:guitar_song_improvement/controller/song_controller.dart';
import 'package:guitar_song_improvement/model/album.dart';
import 'package:guitar_song_improvement/model/artist.dart';
import 'package:guitar_song_improvement/model/song.dart';

class MusicProvider extends ChangeNotifier {
  List<Song>? songs;
  List<Album>? albums;
  List<Artist>? artists;

  bool _isLoaded = false;

  bool get isLoaded => _isLoaded;

  MusicProvider();

  Future<void> getData() async {
    // _isLoaded = false;

    SongController songController = SongController();
    AlbumController albumcontroller = AlbumController();
    ArtistController artistController = ArtistController();

    songs = await songController.readAll();
    albums = await albumcontroller.readAll();
    artists = await artistController.readAll();

    _isLoaded = true;
    notifyListeners();
  }

  // Future<List<Song>> filterSong(String filter) async {
  //   List<Song>? currentSongs = await songs;

  //   filter = filter.toLowerCase();

  //   if (currentSongs == null || currentSongs.isEmpty) {
  //     return [];
  //   }

  //   List<Song>? filteredSongs = currentSongs
  //       .where((song) => song.name.toLowerCase().contains(filter))
  //       .toList();

  //   return filteredSongs;
  // }
}
