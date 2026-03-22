import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/data/model/selected_song_provider.dart';
import 'package:guitar_song_improvement/themes/spacing.dart';
import 'package:guitar_song_improvement/ui/screens/audio/record_audio/view_models/record_audio_viewmodel.dart';
import 'package:guitar_song_improvement/ui/screens/audio/record_audio/widgets/config_util_button.dart';
import 'package:guitar_song_improvement/ui/screens/audio/record_audio/widgets/confirm_send_modal.dart';
import 'package:guitar_song_improvement/ui/screens/audio/record_audio/widgets/initial_timer.dart';
import 'package:guitar_song_improvement/ui/screens/audio/record_audio/widgets/play_animation.dart';
import 'package:guitar_song_improvement/ui/screens/audio/record_audio/widgets/play_button.dart';
import 'package:guitar_song_improvement/ui/screens/audio/record_audio/widgets/record_util_button.dart';
import 'package:guitar_song_improvement/ui/screens/audio/record_audio/widgets/timer_count.dart';
import 'package:provider/provider.dart';

class RecordAudioScreen extends StatefulWidget {
  const RecordAudioScreen({super.key});

  @override
  State<RecordAudioScreen> createState() => _RecordAudioScreenState();
}

class _RecordAudioScreenState extends State<RecordAudioScreen>
    with SingleTickerProviderStateMixin {
  late final RecordAudioViewmodel recordAudioVM;

  late final AnimationController _gradientController;
  late final Animation<Alignment> _beginAlignment;
  late final Animation<Alignment> _endAlignment;

  @override
  void initState() {
    super.initState();

    recordAudioVM = RecordAudioViewmodel();
    recordAudioVM.initValues();

    recordAudioVM.recordState.addListener(_onStateChanged);

    _gradientController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 8),
    );

    _beginAlignment = TweenSequence<Alignment>([
      TweenSequenceItem(
        tween: AlignmentTween(
          begin: Alignment.topLeft,
          end: Alignment.bottomLeft,
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: AlignmentTween(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: AlignmentTween(
          begin: Alignment.topRight,
          end: Alignment.topLeft,
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 1,
      ),
    ]).animate(_gradientController);

    _endAlignment = TweenSequence<Alignment>([
      TweenSequenceItem(
        tween: AlignmentTween(
          begin: Alignment.bottomRight,
          end: Alignment.topRight,
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: AlignmentTween(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: AlignmentTween(
          begin: Alignment.bottomLeft,
          end: Alignment.bottomRight,
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 1,
      ),
    ]).animate(_gradientController);
  }

  void _onStateChanged() {
    if (recordAudioVM.recordState.value == RecordState.recording) {
      _gradientController.repeat();
    } else {
      _gradientController.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _gradientController,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.surface,
                Colors.black87,
                Theme.of(context).colorScheme.surface,
              ],
              begin: _beginAlignment.value,
              end: _endAlignment.value,
            ),
          ),
          child: child,
        );
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
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
                              child: Text(
                                Provider.of<SelectedSongProvider>(
                                  context,
                                  listen: false,
                                ).currentSong.artist,
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
                          Text(
                            Provider.of<SelectedSongProvider>(
                              context,
                              listen: false,
                            ).currentSong.album,
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
                      SizedBox(
                        width: MediaQuery.widthOf(context) - 50,
                        height: 200,
                        child: Stack(
                          children: [
                            Center(
                              child: SizedBox(
                                width: 200,
                                child: PlayAnimation(
                                  state: recordAudioVM.recordState.value,
                                ),
                              ),
                            ),
                            AnimatedOpacity(
                              // add disable to avoid erros
                              duration: Duration(milliseconds: 300),
                              opacity:
                                  (recordAudioVM.recordState.value ==
                                      RecordState.idle)
                                  ? 1
                                  : 0,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    ValueListenableBuilder(
                                      valueListenable:
                                          recordAudioVM.countdownNumberDefined,
                                      builder: (context, value, child) {
                                        return ConfigUtilButton(
                                          recordAudioVM,
                                          icon: Icons.timer_outlined,
                                          label:
                                              "${recordAudioVM.countdownNumberDefined.value}s",
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            AnimatedOpacity(
                              // add disable to avoid erros
                              duration: Duration(milliseconds: 300),
                              opacity:
                                  (recordAudioVM.recordState.value ==
                                          RecordState.recording ||
                                      recordAudioVM.recordState.value ==
                                          RecordState.paused)
                                  ? 1
                                  : 0,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    RecordUtilButton(
                                      icon: Icons.refresh,
                                      onTap: recordAudioVM.restartRecording,
                                    ),
                                    RecordUtilButton(
                                      icon: Icons.pause,
                                      onTap: recordAudioVM.pauseResumeRecording,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        child: Visibility(
                          visible:
                              recordAudioVM.recordState.value !=
                              RecordState.idle,
                          child:
                              (recordAudioVM.recordState.value ==
                                  RecordState.countdown)
                              ? InitialTimer(recordAudioVM)
                              : TimerCount(recordAudioVM: recordAudioVM),
                        ),
                      ),
                      RecordButton(
                        isRecording:
                            (recordAudioVM.recordState.value ==
                                RecordState.recording ||
                            recordAudioVM.recordState.value ==
                                RecordState.paused),
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
    recordAudioVM.recordState.removeListener(_onStateChanged);
    _gradientController.dispose();
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