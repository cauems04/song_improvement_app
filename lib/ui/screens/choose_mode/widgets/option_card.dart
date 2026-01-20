import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/themes/spacing.dart';

class OptionCard extends StatelessWidget {
  final Icon icon;
  final String label;
  final String description;
  final bool isSelected;
  final Function() onTap;

  const OptionCard(
    this.label,
    this.description,
    this.icon, {
    super.key,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: AnimatedContainer(
        padding: EdgeInsets.all(Spacing.sm),
        duration: Duration(milliseconds: 200),
        height: 200,
        width: 300,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerLowest,
          border: BoxBorder.all(
            width: (isSelected) ? 4 : 2,
            color: (isSelected)
                ? Theme.of(context).colorScheme.onPrimary
                : Theme.of(context).colorScheme.surfaceContainerLow,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: Theme.of(
                context,
              ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              description,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            Align(
              alignment: AlignmentGeometry.topRight,
              child: AnimatedOpacity(
                opacity: (isSelected) ? 1 : 0,
                duration: Duration(milliseconds: 200),
                child: Icon(Icons.check_circle, color: Colors.lightGreenAccent),
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        onTap();
      },
    );
  }
}
