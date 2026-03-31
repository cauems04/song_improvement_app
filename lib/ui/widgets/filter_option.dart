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
            onTap: onTap,
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(Spacing.xs),
              child: Row(
                children: [
                  Text(
                    label,
                    style: Theme.of(context).textTheme.bodyMedium!
                        .copyWith(fontSize: 13, fontWeight: FontWeight.bold)
                        .copyWith(
                          color: (isSelected) ? Colors.black : Colors.white,
                        ),
                  ),
                  AnimatedSize(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    child: isSelected
                        ? Padding(
                            padding: const EdgeInsets.only(left: Spacing.xs),
                            child: Transform.translate(
                              offset: Offset(0, -3), // sobe 3px
                              child: Icon(Icons.check, color: Colors.black),
                            ),
                          )
                        : SizedBox.shrink(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
