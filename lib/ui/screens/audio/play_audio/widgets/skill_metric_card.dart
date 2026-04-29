import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/themes/spacing.dart';

class SkillMetricCard extends StatelessWidget {
  final String title;
  final int scoreValue;

  const SkillMetricCard({
    super.key,
    required this.title,
    required this.scoreValue,
  });

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
