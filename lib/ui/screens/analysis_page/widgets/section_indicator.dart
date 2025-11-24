import 'package:flutter/material.dart';

class SectionIndicator extends StatelessWidget {
  final int score;
  const SectionIndicator(this.score, {super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
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
    );
  }
}
