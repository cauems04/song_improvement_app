import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/ui/screens/record_audio_page/record_audio_page.dart';
import 'package:guitar_song_improvement/ui/screens/record_audio_page/widgets/initial_timer.dart';

class PlayButton extends StatelessWidget {
  final RecordState recordState;
  final int secondsToStart;
  final VoidCallback onPressed;
  final VoidCallback onInitialCountFinished;

  const PlayButton({
    super.key,
    required this.recordState,
    required this.secondsToStart,
    required this.onPressed,
    required this.onInitialCountFinished,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 400),
        alignment: Alignment.center,
        width: 250,
        height: 250,
        decoration: BoxDecoration(
          color: (recordState == RecordState.recording)
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.surfaceContainerLowest,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 3),
        ),
        child: (recordState == RecordState.recording)
            ? InitialTimer(secondsToStart, onInitialCountFinished)
            : Icon(Icons.mic, size: 80),
      ),
    );
  }
}
