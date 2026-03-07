import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/controller/link_controller.dart';
import 'package:guitar_song_improvement/controller/record_controller.dart';
import 'package:guitar_song_improvement/controller/song_controller.dart';
import 'package:guitar_song_improvement/data/local/database/dao/analysis_dao.dart';
import 'package:guitar_song_improvement/data/local/database/dao/record_dao.dart';
import 'package:guitar_song_improvement/data/model/analysis.dart';
import 'package:guitar_song_improvement/data/model/dtos/record_with_analysis.dart';
import 'package:guitar_song_improvement/data/model/song.dart';
import 'package:guitar_song_improvement/data/model/link.dart';
import 'package:guitar_song_improvement/ui/screens/analysis/auto_analysis/content/score_type.dart';

class SelectedSongProvider extends ChangeNotifier {
  Song currentSong;
  List<Link>? links;
  List<RecordWithAnalysis>? records;
  List<Analysis>? _analysis;

  int analysisCount = 0;
  List<Analysis>? recentAnalyses;
  List<Analysis>?
  previousAnalyses; //Show message on UI filters for when there's no enough previousAnalyses (to present the trend values / filters)

  bool isInitialized = false;

  bool get isLoaded => (links != null && records != null && _analysis != null);

  Analysis? get getLastAnalysis {
    if (_analysis == null || _analysis!.isEmpty) return null;

    return _analysis!.reduce(
      (current, next) =>
          current.dateCreation.isAfter(next.dateCreation) ? current : next,
    );
  }

  SelectedSongProvider(this.currentSong);

  void setRecentAndPreviousAnalyses() {
    if (_analysis == null) {
      recentAnalyses = null;
      previousAnalyses = null;
      return;
    }

    List<Analysis> sortedAnalyses = [..._analysis!];
    sortedAnalyses.sort((a, b) => b.dateCreation.compareTo(a.dateCreation));

    recentAnalyses = sortedAnalyses.take(5).toList();
    previousAnalyses = sortedAnalyses.skip(5).take(5).toList();
  }

  Future<void> setup() async {
    isInitialized = true;

    LinkController linkController = LinkController();
    links = await linkController.linksBySong(currentSong.id!);

    RecordController recordController = RecordController();
    records = await recordController.recordsBySong(currentSong.id!);

    AnalysisDao analysisDao = AnalysisDao();
    _analysis = await analysisDao.lastAnalysesBySong(currentSong.id!);
    analysisCount = await analysisDao.analysisCount(currentSong.id!);

    if (_analysis != null || _analysis!.isNotEmpty) {
      for (var a in _analysis!) {
        print(a.id);
      }
    } else {
      "No analyses!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!";
    }

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

  Future<void> getAnalysis() async {
    AnalysisDao analysisDao = AnalysisDao();
    _analysis = await analysisDao.lastAnalysesBySong(currentSong.id!);
    analysisCount = await analysisDao.analysisCount(currentSong.id!);

    notifyListeners();
  }

  Future<void> deleteLink(int id) async {
    LinkController linkController = LinkController();
    await linkController.delete(id);

    int linkIndex = links!.indexWhere((link) => link.id == id);
    links!.removeAt(linkIndex);

    notifyListeners();
  }

  Future<void> deleteRecord(int id) async {
    RecordController recordController = RecordController();
    await recordController.delete(id);

    int recordIndex = records!.indexWhere(
      (recordWithAnalysis) => recordWithAnalysis.record.id == id,
    );
    records!.removeAt(recordIndex);

    notifyListeners();
  }

  Future<Analysis> addAnalysis(
    Map<ScoreType, int> scores,
    int? recordId,
  ) async {
    Analysis analysisToCreate = Analysis(
      dateCreation: DateTime.now(),
      // Fix DAOs for record, song, and analysis to guarantee they're passing and retrieving the right values
      pitchScore: scores[ScoreType.pitch]!,
      rhytmScore: scores[ScoreType.rhytm]!,
      dynamicsScore: scores[ScoreType.dynamics]!,
      techniqueScore: scores[ScoreType.technique]!,
      accuracyScore: scores[ScoreType.notation]!,
      songId: currentSong.id!,
    );
    final int analysisId = await AnalysisDao().create(analysisToCreate);

    // print("recordId: $recordId, analysisId: $analysisId");
    await getAnalysis();
    if (recordId != null) {
      await RecordDao().insertAnalysis(recordId, analysisId);
      await getRecords();
    }

    // print("pre-records");
    // records!.forEach((rec) => print(rec.analysis));
    // print("post-records");
    // records!.forEach((rec) => print(rec.analysis));

    notifyListeners();

    return analysisToCreate;
  }
}
