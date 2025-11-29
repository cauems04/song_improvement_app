import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/themes/spacing.dart';

class ScoreSelector extends StatefulWidget {
  final String label;
  final int initialPosition;
  final Function(int highestScore) onTap;
  const ScoreSelector(
    this.label, {
    super.key,
    required this.onTap,
    this.initialPosition = 0,
  });
  @override
  State<ScoreSelector> createState() => ScoreSelectorState();
}

class ScoreSelectorState extends State<ScoreSelector> {
  late int selectedIndex;
  late Color? color;

  @override
  void initState() {
    selectedIndex = widget.initialPosition;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    updateColor();
    color ??= Theme.of(context).colorScheme.onPrimary;
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant ScoreSelector oldWidget) {
    updateColor();
    super.didUpdateWidget(oldWidget);
  }

  void updateColor() {
    color = (selectedIndex == 4)
        ? Colors.yellow[200]
        : Theme.of(context).colorScheme.onPrimary;
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
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (isFilled) ? color : Colors.grey[850],
                  border: BoxBorder.all(
                    color: Theme.of(context).colorScheme.primary,
                    width: 2,
                  ),
                ),
              ),
              onTap: () {
                setState(() {
                  selectedIndex = n;
                  color = color;
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
