import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/themes/spacing.dart';

class WaitTimePicker extends StatelessWidget {
  const WaitTimePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Spacing.md),
      width: 150,
      height: 100,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerLow,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Seconds",
            style: Theme.of(
              context,
            ).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
