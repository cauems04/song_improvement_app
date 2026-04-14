import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/ui/screens/analysis/auto_analysis/content/score_type.dart';

class AutoAnalysisViewModel extends ChangeNotifier {
  late ScoreType currentScoreType;
  late Map<ScoreType, int> scoreValues;

  late bool isLastCard;
  late bool isAnimatingCard;
  late int? recordLinked;

  final PageController pageController = PageController();

  void initValues({int? recordLinked}) {
    currentScoreType = ScoreType.values[0];
    scoreValues = {for (ScoreType type in ScoreType.values) type: 0};
    isLastCard = false;
    isAnimatingCard = false;
    this.recordLinked = recordLinked;
  }

  void changeNextScoreType() {
    final int currentIndex = currentScoreType.index;
    final bool hasNext = currentIndex + 1 < ScoreType.values.length;

    if (hasNext) {
      currentScoreType = ScoreType.values[currentIndex + 1];
    }

    isLastCard = !hasNext;
    isAnimatingCard = false;
    notifyListeners();
  }

  void setAnimating(bool value) {
    isAnimatingCard = value;
    notifyListeners();
  }
}
