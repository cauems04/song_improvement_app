import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/data/model/analysis.dart';
import 'package:guitar_song_improvement/themes/spacing.dart';
import 'package:guitar_song_improvement/ui/screens/audio/play_audio/widgets/skill_metric_card.dart';

class RecordingMetrics extends StatelessWidget {
  final Analysis? analysis;

  const RecordingMetrics({super.key, required this.analysis});

  @override
  Widget build(BuildContext context) {
    final Map<String, Object>? analysisMap = analysis?.toScoresMap();

    final List<MapEntry<String, Object>>? entries = analysisMap?.entries
        .where((e) => e.value is int)
        .toList();

    return (analysis != null)
        ? CustomScrollView(
            shrinkWrap: true,
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: Spacing.xs),
                  child: Text(
                    "Performance Analysis",
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              SliverList.separated(
                itemCount: entries!.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: Spacing.xs),
                itemBuilder: (context, index) {
                  return SkillMetricCard(
                    title: entries[index].key,
                    scoreValue:
                        (entries[index].value as int) +
                        1, // Save adding 1. So no need to fix the value everytime!!!!!!!!!
                  );
                },
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: Spacing.sm),
                  child: Container(
                    padding: EdgeInsets.all(Spacing.md),
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withAlpha(100),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.surface,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text.rich(
                          TextSpan(
                            children: [
                              WidgetSpan(
                                child: Icon(
                                  Icons.bolt_rounded,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onPrimary,
                                ),
                              ),
                              TextSpan(
                                text: "Overall Score",
                                style: Theme.of(context).textTheme.titleLarge!
                                    .copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "${analysis!.getFinalScore}%",
                          style: Theme.of(context).textTheme.titleLarge!
                              .copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: Spacing.lg),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.surfaceContainerLowest,
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).colorScheme.primary,
                        blurRadius: 20,
                        spreadRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(Icons.trending_up, size: 40),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: Spacing.xxl,
                    bottom: Spacing.lg,
                  ),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "Still empty here\n",
                          style: Theme.of(
                            context,
                          ).textTheme.headlineLarge!.copyWith(fontSize: 18),
                        ),
                        TextSpan(
                          text:
                              "Track your progress and see how you're improving across all five abilities.",
                          style: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(
                                fontWeight: FontWeight.w500,
                                color: Colors.white.withAlpha(160),
                              ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Spacing.xl),
                  child: Material(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      child: SizedBox(
                        height: 40,
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            "Add Analysis",
                            style: Theme.of(context).textTheme.titleLarge!
                                .copyWith(fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
