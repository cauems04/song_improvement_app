import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/ui/screens/audio/record_audio/view_models/record_audio_viewmodel.dart';

class InitialTimer extends StatefulWidget {
  final RecordAudioViewmodel recordAudioVM;

  const InitialTimer(this.recordAudioVM, {super.key});

  @override
  State<InitialTimer> createState() => _InitialTimerState();
}

class _InitialTimerState extends State<InitialTimer> {
  @override
  void initState() {
    super.initState();
    widget.recordAudioVM.initTimer();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.recordAudioVM.countdownNumber,
      builder: (context, value, child) {
        return Text(
          widget.recordAudioVM.countdownNumber.value.toString(),
          style: Theme.of(
            context,
          ).textTheme.displayLarge!.copyWith(fontWeight: FontWeight.bold),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    widget.recordAudioVM.timer.cancel();
  }
}
