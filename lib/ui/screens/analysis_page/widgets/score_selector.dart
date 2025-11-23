import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/themes/spacing.dart';

class ScoreSelector extends StatefulWidget {
  final String label;

  final Function(int highestScore) onTap;

  const ScoreSelector(this.label, {super.key, required this.onTap});

  @override
  State<ScoreSelector> createState() => ScoreSelectorState();
}

class ScoreSelectorState extends State<ScoreSelector> {
  late int selectedIndex;

  @override
  void initState() {
    selectedIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: Spacing.lg),
          child: Text(
            widget.label[0].toUpperCase() + widget.label.substring(1),
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(5, (n) {
            bool isFilled = false;

            if (selectedIndex >= n) isFilled = true;

            return GestureDetector(
              child: AnimatedContainer(
                duration: Duration(milliseconds: 120),
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (isFilled)
                      ? Theme.of(context).colorScheme.onPrimary
                      : Colors.grey[850],
                ),
              ),
              onTap: () {
                setState(() {
                  selectedIndex = n;
                  widget.onTap(n);
                });
              },
            );
          }),
        ),
      ],
    );
  }
}
