import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:guitar_song_improvement/ui/screens/analysis/auto_analysis/content/score_type.dart';

const Map<ScoreType, String> scoreInfoText = {
  ScoreType.pitch: "Helper to describe pitch cartegory and how it works",
  ScoreType.rhytm: "Helper to describe rhytm cartegory and how it works",
  ScoreType.dynamics: "Helper to describe dynamics cartegory and how it works",
  ScoreType.technique:
      "Helper to describe technique cartegory and how it works",
  ScoreType.notation: "Helper to describe notation cartegory and how it works",
};

const Map<ScoreType, Color> scoreInfoColor = {
  ScoreType.pitch: Colors.lightBlueAccent,
  ScoreType.rhytm: Colors.lightGreenAccent,
  ScoreType.dynamics: Colors.orangeAccent,
  ScoreType.technique: Colors.purpleAccent,
  ScoreType.notation: Colors.redAccent,
};

const Map<ScoreType, IconData> scoreInfoIcon = {
  ScoreType.pitch: Icons.graphic_eq,
  ScoreType.rhytm: Icons.timer,
  ScoreType.dynamics: Icons.equalizer,
  ScoreType.technique: Icons.build,
  ScoreType.notation: Icons.music_note,
};
