import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/controller/link_controller.dart';
import 'package:guitar_song_improvement/controller/record_controller.dart';
import 'package:guitar_song_improvement/controller/song_controller.dart';
import 'package:guitar_song_improvement/data/local/database/dao/analysis_dao.dart';
import 'package:guitar_song_improvement/data/local/database/dao/record_dao.dart';
import 'package:guitar_song_improvement/data/model/analysis.dart';
import 'package:guitar_song_improvement/data/model/dtos/record_with_analysis.dart';
import 'package:guitar_song_improvement/data/model/metrics/analysis_metrics_mean.dart';
import 'package:guitar_song_improvement/data/model/song.dart';
import 'package:guitar_song_improvement/data/model/link.dart';
import 'package:guitar_song_improvement/ui/screens/analysis/auto_analysis/content/score_type.dart';
import 'package:guitar_song_improvement/ui/screens/song/overview/widgets/trend_indicator.dart';

class SelectedSongProvider extends ChangeNotifier {
  Song currentSong;
  List<Link>? links;
  List<RecordWithAnalysis>? records;
  // List<Analysis>? _analysis;

  int analysisCount = 0;
  List<Analysis>? recentAnalyses;
  List<Analysis>? previousAnalyses;
  //Show message on UI filters for when there's no enough previousAnalyses (to present the trend values / filters)

  int? recentAnalysesMean;
  int? previousAnalysesMean;
  final AnalysisMetricsMean analysisMetricsMean = AnalysisMetricsMean();

  Trend get trend {
    if (recentAnalysesMean == null || previousAnalysesMean == null) {
      return Trend.flat;
    }

    if (recentAnalysesMean! > previousAnalysesMean!) {
      return Trend.up;
    } else if (recentAnalysesMean! < previousAnalysesMean!) {
      return Trend.down;
    } else {
      return Trend.flat;
    }
  }

  bool isInitialized = false;

  bool get isLoaded =>
      (links != null && records != null && recentAnalyses != null);

  Analysis? get getLastAnalysis {
    if (recentAnalyses == null || recentAnalyses!.isEmpty) return null;

    return recentAnalyses!.reduce(
      // check if really necessary for waranty, cause recent analyses will be filled with already sorted data.
      (current, next) =>
          current.dateCreation.isAfter(next.dateCreation) ? current : next,
    );
  }

  SelectedSongProvider(this.currentSong);

  Future<void> setRecentAndPreviousAnalyses() async {
    List<Analysis> sortedAnalyses = (await AnalysisDao().lastAnalysesBySong(
      currentSong.id!,
    ));

    sortedAnalyses.sort((a, b) => b.dateCreation.compareTo(a.dateCreation));

    recentAnalyses = sortedAnalyses.take(5).toList();
    previousAnalyses = sortedAnalyses.skip(5).take(5).toList();

    //mean
    recentAnalysesMean = (recentAnalyses == null || recentAnalyses!.isEmpty)
        ? 0
        : recentAnalyses!.fold(0, (sum, a) => sum + a.getFinalScore) ~/
              recentAnalyses!.length;

    previousAnalysesMean =
        (previousAnalyses == null || previousAnalyses!.isEmpty)
        ? 0
        : previousAnalyses!.fold(0, (sum, a) => sum + a.getFinalScore) ~/
              previousAnalyses!.length;

    analysisMetricsMean.CalculateMetrics(recentAnalyses!, previousAnalyses!);
  }

  Future<void> setup() async {
    isInitialized = true;

    LinkController linkController = LinkController();
    links = await linkController.linksBySong(currentSong.id!);

    RecordController recordController = RecordController();
    records = await recordController.recordsBySong(currentSong.id!);

    await setRecentAndPreviousAnalyses();
    analysisCount = await AnalysisDao().analysisCount(currentSong.id!);

    if (recentAnalyses != null || recentAnalyses!.isNotEmpty) {
      for (var a in recentAnalyses!) {
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
    await setRecentAndPreviousAnalyses();
    analysisCount = await AnalysisDao().analysisCount(currentSong.id!);

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
