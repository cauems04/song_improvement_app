import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/ui/screens/audio/record_audio/view_models/record_audio_viewmodel.dart';
import 'package:guitar_song_improvement/ui/screens/audio/record_audio/widgets/initial_timer.dart';

class PlayButton extends StatefulWidget {
  final RecordAudioViewmodel recordAudioVM;

  const PlayButton({super.key, required this.recordAudioVM});

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
    if (widget.recordAudioVM.recordState.value == RecordState.recording) {
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
        widget.recordAudioVM.handlePlayButtonAction();
      },
      child: RotationTransition(
        turns: buttonController,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 400),
          alignment: Alignment.center,
          width:
              (widget.recordAudioVM.recordState.value ==
                      RecordState.recording ||
                  widget.recordAudioVM.recordState.value == RecordState.paused)
              ? 100
              : 250,
          height:
              (widget.recordAudioVM.recordState.value ==
                      RecordState.recording ||
                  widget.recordAudioVM.recordState.value == RecordState.paused)
              ? 100
              : 250,
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.center,
              colors:
                  (widget.recordAudioVM.recordState.value ==
                          RecordState.recording ||
                      widget.recordAudioVM.recordState.value ==
                          RecordState.paused)
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
          child:
              (widget.recordAudioVM.recordState.value == RecordState.countdown)
              ? InitialTimer(widget.recordAudioVM)
              : Icon(
                  (widget.recordAudioVM.recordState.value ==
                              RecordState.recording ||
                          widget.recordAudioVM.recordState.value ==
                              RecordState.paused)
                      ? Icons.refresh_sharp
                      : Icons.mic,
                  size:
                      (widget.recordAudioVM.recordState.value ==
                              RecordState.recording ||
                          widget.recordAudioVM.recordState.value ==
                              RecordState.paused)
                      ? 40
                      : 80,
                ),
        ),
      ),
    );
  }
}
