import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/data/model/selected_song_provider.dart';
import 'package:guitar_song_improvement/themes/spacing.dart';
import 'package:guitar_song_improvement/ui/screens/analysis/auto_analysis/auto_analysis_screen.dart';
import 'package:guitar_song_improvement/ui/screens/audio/play_audio/view_models/play_audio_viewmodel.dart';
import 'package:guitar_song_improvement/ui/screens/audio/play_audio/view_models/results/save_results.dart';
import 'package:guitar_song_improvement/ui/screens/audio/play_audio/widgets/choose_button.dart';
import 'package:guitar_song_improvement/ui/screens/audio/play_audio/widgets/song_line.dart';
import 'package:guitar_song_improvement/ui/screens/audio/play_audio/widgets/util_button.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

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
    playAudioVM.initValues(
      widget.audioFilePath,
      Provider.of<SelectedSongProvider>(context, listen: false).currentSong,
    );
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
          padding: const EdgeInsets.all(Spacing.xl),
          child: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: IntrinsicWidth(
                                child: TextField(
                                  controller: playAudioVM.nameController,
                                  textAlign: TextAlign.center,
                                  textAlignVertical: TextAlignVertical.center,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.headlineLarge!,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: Spacing.xs),
                              child: Icon(Icons.edit),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: Spacing.xs,
                        ),
                        child: Text(
                          Provider.of<SelectedSongProvider>(
                            context,
                          ).currentSong.artist,
                          style: Theme.of(context).textTheme.bodyLarge!
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                      Text(
                        Provider.of<SelectedSongProvider>(
                          context,
                        ).currentSong.album,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: Spacing.lg),
                  child: SongLine(playAudioVM: playAudioVM),
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
                Row(
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
                        onPressed: () async {
                          Navigator.of(context).pop();
                          playAudioVM.deleteTempFile();
                        },
                        icon: Icon(Icons.delete, size: 24),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: Spacing.sm),
                      child: ChooseButton(
                        color: Theme.of(context).colorScheme.primary,
                        label: "Save",
                        action: () async {
                          final SaveResult result = await playAudioVM
                              .saveRecord();

                          if (!context.mounted) return;

                          //Implement personalized SnackBar
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(result.message)),
                          );

                          if (result is ErrorResult) {
                            Navigator.of(context).pop();
                            return;
                          }

                          Provider.of<SelectedSongProvider>(
                            context,
                            listen: false,
                          ).getRecords();

                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => AutoAnalysisScreen(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
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
