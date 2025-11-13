import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/controller/link_controller.dart';
import 'package:guitar_song_improvement/controller/song_controller.dart';
import 'package:guitar_song_improvement/model/link.dart';
import 'package:guitar_song_improvement/model/song.dart';

class SelectedSongProvider extends ChangeNotifier {
  Song currentSong;
  List<Link>? links;
  List<Record>? records;

  bool get isLoaded => (links != null && records != null);

  SelectedSongProvider(this.currentSong);

  Future<void> setup() async {
    LinkController linkController = LinkController();
    links = await linkController.linksBySong(currentSong.id!);

    records = [];

    notifyListeners();
  }

  Future<void> updateSong(Song newSong) async {
    SongController songController = SongController();
    await songController.update(currentSong, newSong);

    currentSong = Song(
      // Check this later
      id: currentSong.id,
      name: newSong.name,
      artist: newSong.artist,
      album: newSong.album,
    );

    notifyListeners();
  }

  Future<void> getLinks() async {
    LinkController linkController = LinkController();
    links = await linkController.linksBySong(currentSong.id!);

    notifyListeners();
  }

  // Just a test function, when ready, implement the one below this.
  Future<void> getRecords() async {
    records = [];

    notifyListeners();
  }
  // Future<void> getRecords() async {
  //   RecordController recordController = RecordController();
  //   records = await recordController.recordsBySong(currentSong.id!);

  //   notifyListeners();
  // }
}
