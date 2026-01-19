import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/themes/spacing.dart';
import 'package:guitar_song_improvement/ui/screens/analysis/auto_analysis/content/score_info_text.dart';
import 'package:guitar_song_improvement/ui/screens/analysis/auto_analysis/content/score_type.dart';

class ScoreBottomSheet extends StatelessWidget {
  final ScoreType currentScoreType;
  const ScoreBottomSheet(this.currentScoreType, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        gradient: LinearGradient(
          begin: AlignmentGeometry.topCenter,
          end: AlignmentGeometry.bottomCenter,
          colors: [
            Theme.of(context).colorScheme.surfaceContainerLow,
            Theme.of(context).colorScheme.surfaceContainerLowest,
          ],
        ),
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
      ),
      child: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: Spacing.md, bottom: 20),
              child: Text(
                "What does it mean?",
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          SizedBox(
            height: 300, // <-- define a área onde o texto centraliza
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: Spacing.lg,
                  right: Spacing.lg,
                ),
                child: Text(
                  scoreInfoText[currentScoreType]!,
                  textAlign: TextAlign.justify,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
