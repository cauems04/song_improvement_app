import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/data/model/selected_song_provider.dart';
import 'package:guitar_song_improvement/themes/spacing.dart';
import 'package:guitar_song_improvement/ui/screens/audio/record_audio/view_models/record_audio_viewmodel.dart';
import 'package:guitar_song_improvement/ui/screens/audio/record_audio/widgets/confirm_send_modal.dart';
import 'package:guitar_song_improvement/ui/screens/audio/record_audio/widgets/initial_timer.dart';
import 'package:guitar_song_improvement/ui/screens/audio/record_audio/widgets/play_button.dart';
import 'package:guitar_song_improvement/ui/screens/audio/record_audio/widgets/record_management_button.dart';
import 'package:guitar_song_improvement/ui/screens/audio/record_audio/widgets/timer_count.dart';
import 'package:provider/provider.dart';

class RecordAudioScreen extends StatefulWidget {
  const RecordAudioScreen({super.key});

  @override
  State<RecordAudioScreen> createState() => _RecordAudioScreenState();
}

class _RecordAudioScreenState extends State<RecordAudioScreen> {
  late final RecordAudioViewmodel recordAudioVM;

  @override
  void initState() {
    super.initState();

    recordAudioVM = RecordAudioViewmodel();
    recordAudioVM.initValues();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: InkWell(
          customBorder: CircleBorder(),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Icon(Icons.close),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: Spacing.xl),
          child: Expanded(
            child: ValueListenableBuilder(
              valueListenable: recordAudioVM.recordState,
              builder: (context, value, child) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            Provider.of<SelectedSongProvider>(
                              context,
                              listen: false,
                            ).currentSong.name,
                            style: Theme.of(context).textTheme.headlineLarge!
                                .copyWith(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: Spacing.sm,
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    WidgetSpan(
                                      alignment: PlaceholderAlignment.middle,
                                      child: Icon(
                                        Icons.person,
                                        size: 18,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.surfaceContainerHigh,
                                      ),
                                    ),
                                    const WidgetSpan(child: SizedBox(width: 4)),
                                    TextSpan(
                                      text: Provider.of<SelectedSongProvider>(
                                        context,
                                        listen: false,
                                      ).currentSong.artist,
                                    ),
                                  ],
                                ),
                                style: Theme.of(context).textTheme.titleLarge!
                                    .copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.surfaceContainerHigh,
                                    ),
                              ),
                            ),
                          ),
                          Text.rich(
                            TextSpan(
                              children: [
                                WidgetSpan(
                                  alignment: PlaceholderAlignment.middle,
                                  child: Icon(
                                    Icons.library_music,
                                    size: 18,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.surfaceContainer,
                                  ),
                                ),
                                const WidgetSpan(child: SizedBox(width: 4)),
                                TextSpan(
                                  text: Provider.of<SelectedSongProvider>(
                                    context,
                                    listen: false,
                                  ).currentSong.album,
                                ),
                              ],
                            ),
                            style: Theme.of(context).textTheme.titleLarge!
                                .copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.surfaceContainer,
                                ),
                          ),
                        ],
                      ),
                      PlayAnimation(),
                      Visibility(
                        visible:
                            recordAudioVM.recordState.value ==
                                RecordState.countdown ||
                            recordAudioVM.recordState.value ==
                                RecordState.recording,
                        child:
                            (recordAudioVM.recordState.value ==
                                RecordState.countdown)
                            ? InitialTimer(recordAudioVM)
                            : TimerCount(recordAudioVM: recordAudioVM),
                      ),
                      RecordButton(
                        isRecording:
                            recordAudioVM.recordState.value ==
                            RecordState.recording,
                        onTap: () => recordAudioVM.handlePlayButtonAction((
                          filePath,
                        ) {
                          return showDialog(
                            context: context,
                            builder: (newContext) => Center(
                              child: ConfirmSendModal(
                                selectedSongProvider:
                                    Provider.of<SelectedSongProvider>(context),
                                audioFilePath: filePath,
                              ),
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() async {
    await recordAudioVM.cancelRecord();
    super.dispose();
  }
}





// Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.only(right: Spacing.lg),
//                             child: RecordManagementButton(
//                               Icon(Icons.pause),
//                               recordAudioVM.pauseResumeRecording,
//                               disabled:
//                                   (recordAudioVM.recordState.value ==
//                                   RecordState.idle),
//                             ),
//                           ),
//                           RecordManagementButton(
//                             Icon(
//                               Icons.stop,
//                               color: Theme.of(context).colorScheme.onError,
//                             ),
//                             () => recordAudioVM.stopRecording((
//                               String audioFilePath,
//                             ) {
//                               final SelectedSongProvider selectedSongProvider =
//                                   context.read<SelectedSongProvider>();

//                               return showDialog(
//                                 context: context,
//                                 builder: (context) => Center(
//                                   child: ConfirmSendModal(
//                                     selectedSongProvider: selectedSongProvider,
//                                     audioFilePath: audioFilePath,
//                                   ),
//                                 ),
//                               );
//                             }),
//                             disabled:
//                                 (recordAudioVM.recordState.value ==
//                                 RecordState.idle),
//                           ),
//                         ],
//                       ),