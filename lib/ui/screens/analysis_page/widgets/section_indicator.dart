import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/themes/spacing.dart';

class SectionIndicator extends StatelessWidget {
  final int score;
  final bool isSelected;

  final Function() onTap;

  const SectionIndicator(
    this.score, {
    super.key,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => onTap(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: Spacing.sm),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              height: (score + 1) * 12,
              width: 40,
              decoration: BoxDecoration(
                color: (score == 4)
                    ? Colors.yellow[200]
                    : Theme.of(context).colorScheme.onPrimary,
                border: BoxBorder.all(color: Colors.white, width: 2),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
          AnimatedOpacity(
            opacity: isSelected ? 1 : 0,
            duration: Duration(milliseconds: 200),
            child: CircleAvatar(backgroundColor: Colors.white, radius: 6),
          ),
        ],
      ),
    );
  }
}
