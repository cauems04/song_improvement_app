import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/themes/spacing.dart';
import 'package:guitar_song_improvement/ui/screens/audio/play_audio/view_models/play_audio_viewmodel.dart';
import 'package:guitar_song_improvement/ui/screens/audio/play_audio/widgets/choose_button.dart';
import 'package:guitar_song_improvement/ui/screens/audio/play_audio/widgets/song_line.dart';
import 'package:guitar_song_improvement/ui/screens/audio/play_audio/widgets/util_button.dart';

class PlayAudioScreen extends StatefulWidget {
  final String audioFilePath;

  const PlayAudioScreen({super.key, required this.audioFilePath});

  @override
  State<PlayAudioScreen> createState() => _PlayAudioScreenscreeSState();
}

class _PlayAudioScreenscreeSState extends State<PlayAudioScreen> {
  late final PlayAudioViewmodel playAudioVM;

  @override
  void initState() {
    super.initState();
    playAudioVM = PlayAudioViewmodel();
    playAudioVM.initValues(widget.audioFilePath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: AlignmentGeometry.topLeft,
            end: AlignmentGeometry.centerRight,
            colors: [
              Colors.deepPurple[900]!,
              Theme.of(context).colorScheme.surfaceContainerLowest,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Spacing.xl),
          child: SafeArea(
            child: Column(
              children: [
                Expanded(child: TextField()),
                Padding(
                  padding: const EdgeInsets.only(bottom: Spacing.lg),
                  child: SongLine(),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 60),
                  child: OptionsSection(onPlayPressed: playAudioVM.playAudio),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.red[400],
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.delete, size: 24),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: Spacing.sm),
                        child: ChooseButton(
                          color: Theme.of(context).colorScheme.primary,
                          label: "Save",
                          action: () {},
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OptionsSection extends StatelessWidget {
  final VoidCallback onPlayPressed;
  const OptionsSection({super.key, required this.onPlayPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          onPressed: () => null,
          icon: Icon(Icons.replay_10, size: 40),
        ),
        UtilButton(
          icon: Icon(Icons.play_arrow, size: 40),
          isPlay: true,
          onPressed: () => onPlayPressed,
        ),
        IconButton(
          onPressed: () => null,
          icon: Icon(Icons.forward_10, size: 40),
        ),
      ],
    );
  }
}
