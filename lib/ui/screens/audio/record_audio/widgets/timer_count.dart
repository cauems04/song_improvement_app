import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/ui/screens/audio/record_audio/view_models/record_audio_viewmodel.dart';

class TimerCount extends StatelessWidget {
  final RecordAudioViewmodel recordAudioVM;

  const TimerCount({super.key, required this.recordAudioVM});

  String _format(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: recordAudioVM.recordingSeconds,
      builder: (context, value, _) {
        return Text(
          _format(value),
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w600,
            letterSpacing: 4,
          ),
        );
      },
    );
  }
}
