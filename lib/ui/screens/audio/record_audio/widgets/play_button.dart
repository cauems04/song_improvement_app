import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/ui/screens/audio/record_audio/record_audio_screen.dart';
import 'package:guitar_song_improvement/ui/screens/audio/record_audio/widgets/initial_timer.dart';

class PlayButton extends StatefulWidget {
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
  State<PlayButton> createState() => _PlayButtonState();
}

class _PlayButtonState extends State<PlayButton>
    with SingleTickerProviderStateMixin {
  late AnimationController buttonController;

  @override
  void initState() {
    buttonController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 4),
    );
    super.initState();
  }

  @override
  void didUpdateWidget(PlayButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.recordState == RecordState.recording) {
      buttonController.repeat();
      return;
    }

    buttonController.animateTo(0);
    buttonController.stop();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onPressed();
      },
      child: RotationTransition(
        turns: buttonController,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 400),
          alignment: Alignment.center,
          width:
              (widget.recordState == RecordState.recording ||
                  widget.recordState == RecordState.paused)
              ? 100
              : 250,
          height:
              (widget.recordState == RecordState.recording ||
                  widget.recordState == RecordState.paused)
              ? 100
              : 250,
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.center,
              colors:
                  (widget.recordState == RecordState.recording ||
                      widget.recordState == RecordState.paused)
                  ? [
                      Theme.of(context).colorScheme.onPrimary,
                      Theme.of(context).colorScheme.primary,
                    ]
                  : [
                      Theme.of(context).colorScheme.surfaceContainerLow,
                      Theme.of(context).colorScheme.surfaceContainerLowest,
                    ],
            ),
            // color: (recordState == RecordState.countdown)
            //     ? Theme.of(context).colorScheme.primary
            //     : Theme.of(context).colorScheme.surfaceContainerLowest,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 3),
          ),
          child: (widget.recordState == RecordState.countdown)
              ? InitialTimer(
                  widget.secondsToStart,
                  widget.onInitialCountFinished,
                )
              : Icon(
                  (widget.recordState == RecordState.recording ||
                          widget.recordState == RecordState.paused)
                      ? Icons.refresh_sharp
                      : Icons.mic,
                  size:
                      (widget.recordState == RecordState.recording ||
                          widget.recordState == RecordState.paused)
                      ? 40
                      : 80,
                ),
        ),
      ),
    );
  }
}
