import 'package:guitar_song_improvement/data/model/analysis.dart';

class AnalysisMetricsMean {
  double recentPitchMean = 0;
  double previousPitchMean = 0;

  double recentRythmMean = 0;
  double previousRythmMean = 0;

  double recentDynamicsMean = 0;
  double previousDynamicsMean = 0;

  double recentTechniqueMean = 0;
  double previousTechniqueMean = 0;

  double recentAccuracyMean = 0;
  double previousAccuracyMean = 0;

  double _mean(List<Analysis> analyses, int Function(Analysis) score) {
    if (analyses.isEmpty) return 0;
    return analyses.fold(0, (sum, a) => sum + score(a)) / analyses.length;
  }

  void CalculateMetrics(
    List<Analysis> recentAnalyses,
    List<Analysis> previousAnalyses,
  ) {
    recentPitchMean = _mean(recentAnalyses, (analysis) => analysis.pitchScore);
    previousPitchMean = _mean(
      previousAnalyses,
      (analysis) => analysis.pitchScore,
    );

    recentRythmMean = _mean(recentAnalyses, (analysis) => analysis.rhytmScore);
    previousRythmMean = _mean(
      previousAnalyses,
      (analysis) => analysis.rhytmScore,
    );

    recentDynamicsMean = _mean(
      recentAnalyses,
      (analysis) => analysis.dynamicsScore,
    );
    previousDynamicsMean = _mean(
      previousAnalyses,
      (analysis) => analysis.dynamicsScore,
    );

    recentTechniqueMean = _mean(
      recentAnalyses,
      (analysis) => analysis.techniqueScore,
    );
    previousTechniqueMean = _mean(
      previousAnalyses,
      (analysis) => analysis.techniqueScore,
    );

    recentAccuracyMean = _mean(
      recentAnalyses,
      (analysis) => analysis.accuracyScore,
    );
    previousAccuracyMean = _mean(
      previousAnalyses,
      (analysis) => analysis.accuracyScore,
    );
  }
}
