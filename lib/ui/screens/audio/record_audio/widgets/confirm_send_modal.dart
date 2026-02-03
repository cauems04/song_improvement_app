import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/themes/spacing.dart';
import 'package:guitar_song_improvement/ui/screens/audio/play_audio/play_audio_screen.dart';

class ConfirmSendModal extends StatelessWidget {
  final String audioFilePath;

  const ConfirmSendModal({super.key, required this.audioFilePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Spacing.md),
      width: 320,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerLowest,
        border: Border.all(color: Colors.green[200]!, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: Spacing.xs),
                child: Icon(
                  Icons.check_circle,
                  color: Colors.green[200],
                  size: 50,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: Spacing.xl),

                child: Text(
                  "Confirm Send",
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _ConfirmButtom(
                "Cancel",
                Colors.red[600]!,
                action: () => Navigator.of(context).pop(),
              ),
              _ConfirmButtom(
                "Confirm",
                Colors.green[600]!,
                action: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        PlayAudioScreen(audioFilePath: audioFilePath),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ConfirmButtom extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final VoidCallback action;

  const _ConfirmButtom(
    this.label,
    this.backgroundColor, {
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        child: SizedBox(
          height: 50,
          width: 100,
          child: Center(
            child: Text(
              label,
              style: Theme.of(
                context,
              ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
        ),
        onTap: () {
          action();
        },
      ),
    );
  }
}
