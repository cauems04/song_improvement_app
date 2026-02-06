import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/themes/spacing.dart';
import 'package:guitar_song_improvement/ui/screens/audio/play_audio/view_models/play_audio_viewmodel.dart';
import 'package:guitar_song_improvement/ui/screens/audio/play_audio/widgets/choose_button.dart';
import 'package:guitar_song_improvement/ui/screens/audio/play_audio/widgets/song_line.dart';
import 'package:guitar_song_improvement/ui/screens/audio/play_audio/widgets/util_button.dart';
import 'package:just_audio/just_audio.dart';

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
                  child: AnimatedBuilder(
                    animation: Listenable.merge([
                      playAudioVM.isPlaying,
                      playAudioVM.playingState,
                    ]),
                    builder: (context, widget) {
                      return OptionsSection(playAudioVM: playAudioVM);
                    },
                  ),
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
  final PlayAudioViewmodel playAudioVM;
  const OptionsSection({super.key, required this.playAudioVM});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          onPressed: () => playAudioVM.skipDuration(backwards: true),
          icon: Icon(Icons.replay_5, size: 44),
        ),
        UtilButton(
          icon: showPlayButtonIcon(context),
          isPlay: true,
          onPressed: playAudioVM.playAudio,
        ),
        IconButton(
          onPressed: () => playAudioVM.skipDuration(),
          icon: Icon(Icons.forward_5, size: 44),
        ),
      ],
    );
  }

  Icon showPlayButtonIcon(BuildContext context) {
    Icon icon = Icon(Icons.play_arrow, size: 40);

    switch (playAudioVM.playingState.value) {
      case ProcessingState.ready:
        if (playAudioVM.isPlaying.value) {
          icon = Icon(Icons.pause, size: 40);
        }
        break;
      case ProcessingState.completed:
        icon = Icon(Icons.restart_alt, size: 40);
        break;
      default:
        break;
    }

    return icon;
  }
}
