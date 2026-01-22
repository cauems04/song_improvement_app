import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/ui/screens/analysis/auto_analysis/content/score_type.dart';

class AnalysisPageViewModel {
  late ScoreType currentScoreType;
  late Map<ScoreType, int> scoreValues;

  late bool isLastPage;

  final PageController pageController = PageController();
}
