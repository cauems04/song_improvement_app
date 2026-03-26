import 'package:flutter/material.dart';

class SongRecordedAnimation extends StatefulWidget {
  const SongRecordedAnimation({super.key});

  @override
  State<SongRecordedAnimation> createState() => _SongRecordedAnimationState();
}

class _SongRecordedAnimationState extends State<SongRecordedAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController opacityController;

  @override
  void initState() {
    super.initState();

    opacityController = AnimationController(
      vsync: this,
      lowerBound: 0.5,
      upperBound: 1.0,
      duration: Duration(seconds: 1),
    );

    opacityController.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: opacityController,
      child: CircleAvatar(
        minRadius: 70,
        maxRadius: 70,
        backgroundColor: Theme.of(context).colorScheme.primary.withAlpha(100),
        child: CircleAvatar(
          minRadius: 50,
          maxRadius: 50,
          backgroundColor: Theme.of(
            context,
          ).colorScheme.primary.withAlpha(2000),
          child: CircleAvatar(
            minRadius: 30,
            maxRadius: 30,
            backgroundColor: const Color.fromARGB(255, 181, 97, 253),
            child: Icon(Icons.check, size: 44, fontWeight: FontWeight.w900),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    opacityController.dispose();
    super.dispose();
  }
}
