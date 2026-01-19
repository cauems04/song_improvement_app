import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/themes/spacing.dart';

class BoxForm extends StatelessWidget {
  final Widget child;

  const BoxForm({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          Spacing.xs,
          Spacing.xs,
          Spacing.xs,
          Spacing.sm,
        ),
        child: child,
      ),
    );
  }
}
