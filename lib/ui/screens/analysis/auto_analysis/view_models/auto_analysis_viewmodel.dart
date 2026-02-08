import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/data/services/score_service.dart';
import 'package:guitar_song_improvement/ui/screens/analysis/auto_analysis/content/score_type.dart';

class AutoAnalysisViewModel extends ChangeNotifier {
  late ScoreType currentScoreType;
  late Map<ScoreType, int> scoreValues;

  late bool isLastPage;
  late int? recordLinked;

  final PageController pageController = PageController();

  final ScoreService _scoreService = ScoreService();
  int get finalScore => _scoreService.normalizedFinalScore;

  void initValues({int? recordLinked}) {
    currentScoreType = ScoreType.values[0];
    scoreValues = {for (ScoreType type in ScoreType.values) type: 0};
    isLastPage = false;
    recordLinked = recordLinked;
  }

  void changePage(int value) {
    isLastPage = value == (ScoreType.values.length - 1);
    currentScoreType = ScoreType.values[value];
  }

  void selectScore(int value, ScoreType type) {
    scoreValues[type] = value;
    if (!isLastPage) {
      pageController.nextPage(
        duration: Duration(milliseconds: 400),
        curve: Curves.ease,
      );
    }

    notifyListeners();
  }

  void calculateScore() {
    _scoreService.calculateScore(scoreValues);
  }
}
