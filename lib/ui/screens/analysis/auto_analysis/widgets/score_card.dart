import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/themes/spacing.dart';
import 'package:guitar_song_improvement/ui/screens/analysis/auto_analysis/content/drag_card_data.dart';
import 'package:guitar_song_improvement/ui/screens/analysis/auto_analysis/content/score_info.dart';
import 'package:guitar_song_improvement/ui/screens/analysis/auto_analysis/content/score_type.dart';

class DraggableScoreCard extends StatelessWidget {
  final ScoreType scoreType;

  const DraggableScoreCard({super.key, required this.scoreType});

  @override
  Widget build(BuildContext context) {
    final double endAnimationScale = 0.4;
    final Widget child = ScoreCard(scoreType: scoreType);

    return Draggable(
      data: DragCardData(scoreType: scoreType, scale: endAnimationScale),
      childWhenDragging: SizedBox.shrink(),
      feedback: Material(
        color: Colors.transparent,
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 1.0, end: endAnimationScale),
          duration: Duration(milliseconds: 200),
          builder: (context, value, _) {
            return Transform.scale(scale: value, child: child);
          },
        ),
      ),
      child: child,
      onDraggableCanceled: (velocity, offset) {
        // aqui você dispara a animação de volta
      },
    );
  }
}

class ScoreCard extends StatelessWidget {
  final ScoreType scoreType;

  const ScoreCard({super.key, required this.scoreType});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Spacing.sm),
      width: 220,
      height: 250,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            scoreInfoColor[scoreType]!,
            Color.lerp(
              scoreInfoColor[scoreType]!,
              Theme.of(context).colorScheme.primary,
              0.8,
            )!,
          ],
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                scoreType.name,
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(scoreInfoIcon[scoreType]),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: Spacing.lg),
              child: Text(
                scoreInfoText[scoreType]!,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Colors.white.withAlpha(220),
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
          ),
          Text(
            "Drag and drop on the rate",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Colors.white70,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
