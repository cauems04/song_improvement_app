import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/themes/spacing.dart';
import 'package:guitar_song_improvement/ui/screens/song/overview/widgets/trend_indicator.dart';

class SkillProgressBar extends StatelessWidget {
  final String title;
  final double scoreValueMean;
  final double previousValueMean;
  final Trend trend;

  const SkillProgressBar({
    super.key,
    required this.title,
    required this.trend,
    required this.scoreValueMean,
    required this.previousValueMean,
  });

  String formatScore(double value) {
    return value % 1 == 0 ? value.toInt().toString() : value.toStringAsFixed(1);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Spacing.sm),
      height: 80,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.surfaceContainerLowest.withAlpha(100),
            Colors.blueAccent[100]!.withAlpha(40),
          ],
        ),
        // color: Theme.of(
        //   context,
        // ).colorScheme.surfaceContainerLowest.withAlpha(100),
        border: Border.all(color: Theme.of(context).colorScheme.surface),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: Spacing.sm),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: Spacing.sm),
                      child: Text(
                        title,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    TrendIndicator(trend: trend),
                  ],
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "${formatScore(scoreValueMean)} / 5",
                        style: Theme.of(
                          context,
                        ).textTheme.headlineLarge!.copyWith(fontSize: 16),
                      ),
                      WidgetSpan(
                        child: Padding(
                          padding: const EdgeInsets.only(left: Spacing.xs),
                          child: Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.white54,
                            size: 16,
                          ),
                        ),
                      ),
                      TextSpan(
                        text: formatScore(previousValueMean),
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Colors.white54,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          LinearProgressIndicator(
            value: scoreValueMean.toDouble() / 5,
            color: Theme.of(context).colorScheme.onPrimary,
            borderRadius: BorderRadius.circular(10),
            minHeight: 12,
            valueColor: AlwaysStoppedAnimation<Color>(
              Theme.of(context).colorScheme.onPrimary.withAlpha(200),
            ),
            backgroundColor: Theme.of(
              context,
            ).colorScheme.onPrimary.withAlpha(50),
          ),
        ],
      ),
    );
  }
}
