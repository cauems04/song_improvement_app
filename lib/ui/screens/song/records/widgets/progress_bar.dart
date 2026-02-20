import 'package:flutter/material.dart';

class ProgressBar extends StatefulWidget {
  final double progressValue;
  const ProgressBar({super.key, required this.progressValue});

  @override
  State<ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar>
    with TickerProviderStateMixin {
  late AnimationController progressController;
  late Animation<double> curvedProgressController;

  @override
  void initState() {
    super.initState();
    progressController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    curvedProgressController = CurvedAnimation(
      parent: progressController,
      curve: Curves.easeOut,
    );

    progressController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.surfaceContainerLowest.withAlpha(140),
            Theme.of(context).colorScheme.surfaceContainerLow.withAlpha(160),
          ],
        ),
        border: Border.all(
          color: Theme.of(context).colorScheme.surfaceContainerLow,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: AnimatedBuilder(
          animation: curvedProgressController,
          builder: (context, child) {
            return FractionallySizedBox(
              widthFactor:
                  curvedProgressController.value *
                  widget.progressValue, // Usa fator de 0.0 a 1.0
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.primary.withAlpha(180),
                      Theme.of(context).colorScheme.onPrimary.withAlpha(180),
                    ],
                  ),
                  border: Border.all(
                    color: Theme.of(
                      context,
                    ).colorScheme.onPrimary.withAlpha(140),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    progressController.dispose();
    super.dispose();
  }
}
