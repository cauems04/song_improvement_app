import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/themes/spacing.dart';
import 'package:guitar_song_improvement/ui/screens/audio/play_audio/view_models/play_audio_viewmodel.dart';

class SongLine extends StatefulWidget {
  final PlayAudioViewmodel playAudioVM;
  const SongLine({super.key, required this.playAudioVM});

  @override
  State<SongLine> createState() => _SongLineState();
}

class _SongLineState extends State<SongLine> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        widget.playAudioVM.totalDuration,
        widget.playAudioVM.currentDuration,
      ]),
      builder: (context, _) {
        final double totalDuration = widget
            .playAudioVM
            .totalDuration
            .value
            .inMilliseconds
            .toDouble();

        final double currentPosition = widget
            .playAudioVM
            .currentDuration
            .value
            .inMilliseconds
            .toDouble();

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: Spacing.xs),
              child: SliderTheme(
                data: SliderThemeData(
                  trackHeight: 2,
                  overlayShape: SliderComponentShape.noOverlay,
                  thumbColor: Theme.of(context).colorScheme.onPrimary,
                ),
                child: Slider(
                  value: currentPosition.clamp(0, totalDuration),
                  min: 0,
                  max: totalDuration,
                  onChanged: (value) => {
                    widget.playAudioVM.seekPosition(value),
                  },
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  formatTime(widget.playAudioVM.currentDuration.value),
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w500),
                ),
                Text(
                  formatTime(widget.playAudioVM.totalDuration.value),
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  String formatTime(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '${minutes.toString().padLeft(1, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
