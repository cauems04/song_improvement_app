import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/model/song.dart';

class SongsProvider extends ChangeNotifier {
  Future<List<Song>>? songs;

  SongsProvider();
}
