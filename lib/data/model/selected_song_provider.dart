import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/controller/link_controller.dart';
import 'package:guitar_song_improvement/controller/record_controller.dart';
import 'package:guitar_song_improvement/controller/song_controller.dart';
import 'package:guitar_song_improvement/data/model/song.dart';
import 'package:guitar_song_improvement/data/model/link.dart';
import 'package:guitar_song_improvement/data/model/record.dart';

class SelectedSongProvider extends ChangeNotifier {
  Song currentSong;
  List<Link>? links;
  List<Record>? records;

  bool isInitialized = false;

  bool get isLoaded => (links != null && records != null);

  SelectedSongProvider(this.currentSong);

  Future<void> setup() async {
    isInitialized = true;

    LinkController linkController = LinkController();
    links = await linkController.linksBySong(currentSong.id!);

    RecordController recordController = RecordController();
    records = await recordController.recordsBySong(currentSong.id!);

    notifyListeners();
  }

  Future<void> updateSong() async {
    SongController songController = SongController();
    final Song song = await songController.read(currentSong.id!);

    currentSong = song;

    notifyListeners();
  }

  Future<void> updateScore(int newScore, int? recordId) async {
    SongController songController = SongController();
    RecordController recordController = RecordController();

    await songController.updateScore(currentSong, newScore);
    if (recordId != null) {
      final Record recordFound = records!.firstWhere(
        (record) => record.id == recordId,
      );
      recordFound.score = newScore;
      await recordController.update(recordId, recordFound);
    }

    currentSong = await songController.read(currentSong.id!);

    notifyListeners();
  }

  Future<void> getLinks() async {
    LinkController linkController = LinkController();
    links = await linkController.linksBySong(currentSong.id!);

    notifyListeners();
  }

  // Just a test function, when ready, implement the one below this.
  Future<void> getRecords() async {
    RecordController recordController = RecordController();
    records = await recordController.recordsBySong(currentSong.id!);

    notifyListeners();
  }

  Future<void> deleteLink(int id) async {
    LinkController linkController = LinkController();
    await linkController.delete(id);

    int linkIndex = links!.indexWhere((link) => link.id == id);
    links!.removeAt(linkIndex);
  }

  Future<void> deleteRecord(int id) async {
    RecordController recordController = RecordController();
    await recordController.delete(id);

    int recordIndex = records!.indexWhere((record) => record.id == id);
    records!.removeAt(recordIndex);
  }

  // Future<void> getRecords() async {
  //   RecordController recordController = RecordController();
  //   records = await recordController.recordsBySong(currentSong.id!);

  //   notifyListeners();
  // }
}
