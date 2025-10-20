import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/model/song.dart';

class SongsProvider extends ChangeNotifier {
  Future<List<Song>>? songs;

  SongsProvider();

  Future<List<Song>> filterSong(String filter) async {
    List<Song>? currentSongs = await songs;

    filter = filter.toLowerCase();

    if (currentSongs == null || currentSongs.isEmpty) {
      return [];
    }

    List<Song>? filteredSongs = currentSongs
        .where((song) => song.name.toLowerCase().contains(filter))
        .toList();

    return filteredSongs;
  }
}
