import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/data/model/analysis.dart';
import 'package:guitar_song_improvement/data/model/selected_song_provider.dart';
import 'package:guitar_song_improvement/themes/spacing.dart';
import 'package:guitar_song_improvement/ui/screens/analysis/auto_analysis/auto_analysis_screen.dart';
import 'package:guitar_song_improvement/ui/screens/audio/play_audio/view_models/play_audio_viewmodel.dart';
import 'package:guitar_song_improvement/ui/screens/audio/play_audio/view_models/results/save_results.dart';
import 'package:guitar_song_improvement/ui/screens/audio/play_audio/widgets/choose_button.dart';
import 'package:guitar_song_improvement/ui/screens/audio/play_audio/widgets/recordingMetrics.dart';
import 'package:guitar_song_improvement/ui/screens/audio/play_audio/widgets/songRecordedAnimation.dart';
import 'package:guitar_song_improvement/ui/screens/audio/play_audio/widgets/song_line.dart';
import 'package:guitar_song_improvement/ui/screens/audio/play_audio/widgets/util_button.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

class PlayAudioScreen extends StatefulWidget {
  final String audioFilePath;
  final Analysis? recordingAnalysis;
  final bool isAudioAlreadySaved;

  const PlayAudioScreen({
    super.key,
    required this.audioFilePath,
    this.recordingAnalysis,
    this.isAudioAlreadySaved = false,
  });

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
      backgroundColor: Colors.black,
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.surface,
              Theme.of(context).colorScheme.surface,
              Theme.of(context).colorScheme.surface.withAlpha(40),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(Spacing.xl),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: IntrinsicWidth(
                              child: TextField(
                                controller: playAudioVM.nameController,
                                textAlign: TextAlign.center,
                                textAlignVertical: TextAlignVertical.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineLarge!
                                    .copyWith(fontWeight: FontWeight.bold),
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
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Text(
                          playAudioVM.songArtist,
                          style: Theme.of(context).textTheme.titleLarge!
                              .copyWith(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                        ),
                      ),
                      Text(
                        playAudioVM.songAlbum,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.surfaceContainer,
                        ),
                      ),
                    ],
                  ),
                  (!widget.isAudioAlreadySaved)
                      ? Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SongRecordedAnimation(),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: Spacing.lg,
                                bottom: Spacing.xs,
                              ),
                              child: Text(
                                "Recording Saved!",
                                style: Theme.of(
                                  context,
                                ).textTheme.headlineLarge,
                              ),
                            ),
                            Text(
                              "Your audio has been captured",
                              style: Theme.of(context).textTheme.bodyMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white.withAlpha(160),
                                  ),
                            ),
                          ],
                        )
                      : Flexible(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: Spacing.lg,
                            ),
                            child: RecordingMetrics(
                              analysis: widget.recordingAnalysis,
                            ),
                          ),
                        ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: Spacing.lg),
                        child: SongLine(playAudioVM: playAudioVM),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 45),
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
                      Visibility(
                        visible: !widget.isAudioAlreadySaved,
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
                                onPressed: () async {
                                  Navigator.of(context).pop();
                                  playAudioVM.deleteTempFile();
                                },
                                icon: Icon(
                                  Icons.delete,
                                  size: 24,
                                  color: Colors.white.withAlpha(200),
                                ),
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
                                      builder: (newContext) =>
                                          ChangeNotifierProvider.value(
                                            value:
                                                Provider.of<
                                                  SelectedSongProvider
                                                >(context, listen: false),
                                            child: AutoAnalysisScreen(
                                              recordLinkedId:
                                                  (result as SuccessResult)
                                                      .recordId,
                                            ),
                                          ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
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
          icon: Icon(
            Icons.replay_5,
            size: 44,
            color: Colors.white.withAlpha(200),
          ),
        ),
        UtilButton(
          icon: showPlayButtonIcon(context),
          isPlay: true,
          onPressed: playAudioVM.playAudio,
        ),
        IconButton(
          onPressed: () => playAudioVM.skipDuration(),
          icon: Icon(
            Icons.forward_5,
            size: 44,
            color: Colors.white.withAlpha(200),
          ),
        ),
      ],
    );
  }

  Icon showPlayButtonIcon(BuildContext context) {
    Icon icon = Icon(
      Icons.play_arrow,
      size: 30,
      color: Colors.white.withAlpha(200),
    );

    switch (playAudioVM.playingState.value) {
      case ProcessingState.ready:
        if (playAudioVM.isPlaying.value) {
          icon = Icon(
            Icons.pause,
            size: 30,
            color: Colors.white.withAlpha(200),
          );
        }
        break;
      case ProcessingState.completed:
        icon = Icon(Icons.replay, size: 30, color: Colors.white.withAlpha(200));
        break;
      default:
        break;
    }

    return icon;
  }
}
