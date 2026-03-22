import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/data/model/selected_song_provider.dart';
import 'package:guitar_song_improvement/themes/dark_theme.dart';
import 'package:guitar_song_improvement/themes/spacing.dart';
import 'package:guitar_song_improvement/ui/screens/audio/play_audio/play_audio_screen.dart';
import 'package:provider/provider.dart';

// class ConfirmSendModal extends StatelessWidget {
//   final SelectedSongProvider selectedSongProvider;
//   final String audioFilePath;

//   const ConfirmSendModal({
//     super.key,
//     required this.selectedSongProvider,
//     required this.audioFilePath,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(Spacing.md),
//       width: 320,
//       decoration: BoxDecoration(
//         color: Theme.of(context).colorScheme.surfaceContainerLowest,
//         border: Border.all(color: Colors.green[200]!, width: 2),
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(bottom: Spacing.xs),
//                 child: Icon(
//                   Icons.check_circle,
//                   color: Colors.green[200],
//                   size: 50,
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(bottom: Spacing.xl),

//                 child: Text(
//                   "Confirm Send",
//                   style: Theme.of(context).textTheme.headlineSmall!.copyWith(
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               _ConfirmButtom(
//                 "Cancel",
//                 Colors.red[600]!,
//                 action: () => Navigator.of(context).pop(),
//               ),
//               _ConfirmButtom(
//                 "Confirm",
//                 Colors.green[600]!,
//                 action: () => Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (newContext) => ChangeNotifierProvider.value(
//                       value: selectedSongProvider,
//                       child: PlayAudioScreen(audioFilePath: audioFilePath),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

class ConfirmSendModal extends StatelessWidget {
  final SelectedSongProvider selectedSongProvider;
  final String audioFilePath;

  const ConfirmSendModal({
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
            _AnimatedDiskIcon(),
            Text(
              "Save Recording?",
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

class _AnimatedDiskIcon extends StatefulWidget {
  const _AnimatedDiskIcon();

  @override
  State<_AnimatedDiskIcon> createState() => _AnimatedDiskIconState();
}

class _AnimatedDiskIconState extends State<_AnimatedDiskIcon>
    with SingleTickerProviderStateMixin {
  late final AnimationController iconController;

  @override
  void initState() {
    super.initState();
    iconController = AnimationController(
      vsync: this,
      lowerBound: 0.85,
      upperBound: 1.0,
      duration: Duration(seconds: 1),
    );
    iconController.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      height: 60,
      child: AnimatedBuilder(
        animation: iconController,
        builder: (context, child) {
          return Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Theme.of(context).colorScheme.onPrimary,
                width: 3,
              ),
            ),
            child: Icon(
              Icons.album,
              size: 40 * iconController.value,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          );
        },
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
