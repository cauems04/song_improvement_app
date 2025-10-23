import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/themes/spacing.dart';

class FilterOption extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Function() onTap;

  const FilterOption({
    super.key,
    required this.label,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        Spacing.xs,
        Spacing.none,
        Spacing.xs,
        Spacing.none,
      ),
      child: Material(
        color: (isSelected)
            ? Theme.of(context).colorScheme.onPrimary
            : Theme.of(context).colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(10),
        child: Ink(
          decoration: BoxDecoration(),
          child: InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(Spacing.xs),
              child: Text(
                label,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            onTap: () {
              onTap();
            },
          ),
        ),
      ),
    );
  }
}
