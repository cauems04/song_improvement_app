import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/ui/screens/record_audio_page/widgets/initial_timer.dart';

class PlayButton extends StatefulWidget {
  final int secondsToStart;

  const PlayButton(this.secondsToStart, {super.key});

  @override
  State<PlayButton> createState() => _PlayButtonState();
}

class _PlayButtonState extends State<PlayButton> {
  late bool isActive;

  @override
  void initState() {
    isActive = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isActive = !isActive;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 400),
        alignment: Alignment.center,
        width: 250,
        height: 250,
        decoration: BoxDecoration(
          color: (isActive)
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.surfaceContainerLowest,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 3),
        ),
        child: (isActive)
            ? InitialTimer(widget.secondsToStart)
            : Icon(Icons.mic, size: 80),
      ),
    );
  }
}
