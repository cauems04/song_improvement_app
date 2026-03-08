import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/data/model/selected_song_provider.dart';
import 'package:guitar_song_improvement/themes/spacing.dart';
import 'package:guitar_song_improvement/ui/screens/song/overview/widgets/trend_indicator.dart';
import 'package:provider/provider.dart';

class OverallCard extends StatelessWidget {
  const OverallCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        color: Theme.of(
          context,
        ).colorScheme.surfaceContainerLowest.withAlpha(100),
        border: Border.all(
          color: Theme.of(context).colorScheme.surfaceContainerLow,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Spacing.md,
          vertical: Spacing.md,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: Padding(
                          padding: const EdgeInsets.only(right: Spacing.xs),
                          child: Icon(
                            Icons.show_chart,
                            color: Colors.blueAccent,
                          ),
                        ),
                      ),
                      TextSpan(
                        text: "General Rate",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
                TrendIndicator(
                  trend: Provider.of<SelectedSongProvider>(context).trend,
                  score: 80,
                ),
              ],
            ),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text:
                        "${Provider.of<SelectedSongProvider>(context, listen: false).recentAnalysesMean}%",
                    style: Theme.of(
                      context,
                    ).textTheme.headlineLarge!.copyWith(fontSize: 40),
                  ),
                  WidgetSpan(
                    child: Padding(
                      padding: const EdgeInsets.only(left: Spacing.xs),
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white54,
                        size: 20,
                      ),
                    ),
                  ),
                  TextSpan(
                    text:
                        "${Provider.of<SelectedSongProvider>(context, listen: false).previousAnalysesMean}%",
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      fontSize: 20,
                      color: Colors.white54,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              "Average performance across recent analyses",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
