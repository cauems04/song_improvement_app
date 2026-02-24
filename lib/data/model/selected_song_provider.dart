import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/controller/link_controller.dart';
import 'package:guitar_song_improvement/controller/record_controller.dart';
import 'package:guitar_song_improvement/controller/song_controller.dart';
import 'package:guitar_song_improvement/data/local/database/dao/analysis_dao.dart';
import 'package:guitar_song_improvement/data/model/analysis.dart';
import 'package:guitar_song_improvement/data/model/song.dart';
import 'package:guitar_song_improvement/data/model/link.dart';
import 'package:guitar_song_improvement/data/model/record.dart';
import 'package:guitar_song_improvement/ui/screens/analysis/auto_analysis/content/score_type.dart';

class SelectedSongProvider extends ChangeNotifier {
  Song currentSong;
  List<Link>? links;
  List<Record>? records;
  List<Analysis>? analysis;

  bool isInitialized = false;

  bool get isLoaded => (links != null && records != null && analysis != null);

  SelectedSongProvider(this.currentSong);

  Future<void> setup() async {
    isInitialized = true;

    LinkController linkController = LinkController();
    links = await linkController.linksBySong(currentSong.id!);

    RecordController recordController = RecordController();
    records = await recordController.recordsBySong(currentSong.id!);

    AnalysisDao analysisDao = AnalysisDao();
    analysis = await analysisDao.analysisBySong(currentSong.id!);

    notifyListeners();
  }

  Future<void> updateSong() async {
    SongController songController = SongController();
    final Song song = await songController.read(currentSong.id!);

    currentSong = song;

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

  Future<void> addAnalysis(Map<ScoreType, int> scores, int finalScore) async {
    Analysis analysisToCreate = Analysis(
      dateCreation: DateTime.now(),
      score: finalScore,
      pitchScore: scores[ScoreType.pitch]!,
      rhytmScore: scores[ScoreType.rhytm]!,
      dynamicsScore: scores[ScoreType.dynamics]!,
      techniqueScore: scores[ScoreType.technique]!,
      accuracyScore: scores[ScoreType.notation]!,
      songId: currentSong.id!,
    );
    AnalysisDao().create(analysisToCreate);

    notifyListeners();
  }
}
