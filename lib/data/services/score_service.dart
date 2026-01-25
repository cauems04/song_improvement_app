import 'package:guitar_song_improvement/ui/screens/analysis/auto_analysis/content/score_type.dart';

class ScoreService {
  static const int minFinalValue = 5;
  static const int maxFinalValue = 25;

  double finalScore = 0;

  int get normalizedFinalScore {
    return (finalScore * 100).toInt();
  }

  void calculateScore(Map<ScoreType, int> scores) {
    int sum = 0;
    for (ScoreType scoreType in scores.keys) {
      sum += (scores[scoreType]! + 1);
    }

    finalScore = (sum - minFinalValue) / (maxFinalValue - minFinalValue);
  }
}
