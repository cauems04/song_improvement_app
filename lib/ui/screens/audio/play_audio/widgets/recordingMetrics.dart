import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/data/model/analysis.dart';
import 'package:guitar_song_improvement/themes/spacing.dart';

class RecordingMetrics extends StatelessWidget {
  final Analysis? analysis;

  const RecordingMetrics({super.key, required this.analysis});

  @override
  Widget build(BuildContext context) {
    final Map<String, Object> analysisMap = analysis!.toScoresMap();

    final List<MapEntry<String, Object>> entries = analysisMap.entries
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
                itemCount: entries.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: Spacing.xs),
                itemBuilder: (context, index) {
                  return SkillMetric(
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
                        Text(
                          "Overall Score",
                          style: Theme.of(context).textTheme.titleLarge!
                              .copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
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
        : Text("Add new");
  }
}

class SkillMetric extends StatelessWidget {
  final String title;
  final int scoreValue;

  const SkillMetric({super.key, required this.title, required this.scoreValue});

  String formatScore(double value) {
    return value % 1 == 0 ? value.toInt().toString() : value.toStringAsFixed(1);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Spacing.sm),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(25),
        border: Border.all(color: Theme.of(context).colorScheme.surface),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: Spacing.sm),
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Row(
                children: List.generate(5, (index) {
                  return (index + 1 <= scoreValue)
                      ? Icon(
                          Icons.star_rounded,
                          color: Theme.of(context).colorScheme.onPrimary,
                        )
                      : Icon(
                          Icons.star_border_rounded,
                          color: Theme.of(context).colorScheme.onPrimary,
                        );
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
