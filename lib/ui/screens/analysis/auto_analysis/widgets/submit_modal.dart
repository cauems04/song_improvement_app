import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/data/model/selected_song_provider.dart';
import 'package:guitar_song_improvement/themes/dark_theme.dart';
import 'package:guitar_song_improvement/themes/spacing.dart';
import 'package:guitar_song_improvement/ui/screens/audio/play_audio/play_audio_screen.dart';
import 'package:provider/provider.dart';

class SubmitModal extends StatelessWidget {
  final SelectedSongProvider selectedSongProvider;
  final String audioFilePath;

  const SubmitModal({
    super.key,
    required this.selectedSongProvider,
    required this.audioFilePath,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.fromLTRB(
          Spacing.lg,
          Spacing.xl,
          Spacing.lg,
          Spacing.md,
        ),
        decoration: BoxDecoration(
          color: DarkThemeColors.defaultModal,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "Make Analysis?",
              style: Theme.of(
                context,
              ).textTheme.headlineLarge!.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              "Your performance has been captured",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Colors.white60,
                fontWeight: FontWeight.w500,
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: Spacing.md),
                  child: _ConfirmButtom(
                    "Save Audio",
                    [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.onPrimary,
                    ],
                    action: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (newContext) => ChangeNotifierProvider.value(
                          value: selectedSongProvider,
                          child: PlayAudioScreen(audioFilePath: audioFilePath),
                        ),
                      ),
                    ),
                  ),
                ),
                _ConfirmButtom("Delete Recording", [
                  Theme.of(
                    context,
                  ).colorScheme.surfaceContainerLowest.withAlpha(100),
                  Theme.of(context).colorScheme.surfaceContainerLow,
                ], action: () => Navigator.of(context).pop()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ConfirmButtom extends StatelessWidget {
  final String label;
  final List<Color> backgroundColors;
  final VoidCallback action;

  const _ConfirmButtom(
    this.label,
    this.backgroundColors, {
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        child: Ink(
          height: 50,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: backgroundColors),
            borderRadius: BorderRadius.circular(10),
          ),
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
