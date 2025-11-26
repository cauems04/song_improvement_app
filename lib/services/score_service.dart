import 'package:guitar_song_improvement/ui/screens/analysis_page/content/score_type.dart';

class ScoreService {
  final Map<ScoreType, int> scores;

  static const int minFinalValue = 5;
  static const int maxFinalValue = 25;

  late double finalScore;

  int get normalizedFinalScore {
    return (finalScore * 100).toInt();
  }

  ScoreService(this.scores);

  void calculateScore() {
    int sum = 0;
    for (ScoreType scoreType in scores.keys) {
      sum += (scores[scoreType]! + 1);
    }

    finalScore = (sum - minFinalValue) / (maxFinalValue - minFinalValue);
  }
}
