import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/themes/spacing.dart';
import 'package:guitar_song_improvement/ui/screens/audio/record_audio/view_models/record_audio_viewmodel.dart';
import 'package:guitar_song_improvement/ui/screens/audio/record_audio/widgets/confirm_send_modal.dart';
import 'package:guitar_song_improvement/ui/screens/audio/record_audio/widgets/play_button.dart';
import 'package:guitar_song_improvement/ui/screens/audio/record_audio/widgets/record_management_button.dart';
import 'package:guitar_song_improvement/ui/screens/audio/record_audio/widgets/time_value_picker.dart';
import 'package:guitar_song_improvement/ui/screens/audio/record_audio/widgets/wave_animation.dart';

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
      body: Padding(
        padding: const EdgeInsets.only(top: 100, bottom: Spacing.md),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: recordAudioVM.recordState,
                builder: (context, value, child) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Visibility(
                        visible:
                            (recordAudioVM.recordState.value ==
                            RecordState.recording),
                        child: Text(
                          "Tap to restart",
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: Spacing.md,
                          bottom: Spacing.xxl,
                        ),
                        child: PlayButton(recordAudioVM: recordAudioVM),
                      ),
                      AnimatedSize(
                        duration: Duration(milliseconds: 400),
                        child: SizedBox(
                          height:
                              (recordAudioVM.recordState.value ==
                                  RecordState.recording)
                              ? 200
                              : 0,
                          child:
                              (recordAudioVM.recordState.value ==
                                  RecordState.recording)
                              ? WaveAnimation()
                              : null,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: Spacing.lg),
                            child: RecordManagementButton(
                              Icon(Icons.pause),
                              recordAudioVM.pauseResumeRecording,
                              disabled:
                                  (recordAudioVM.recordState.value ==
                                  RecordState.idle),
                            ),
                          ),
                          RecordManagementButton(
                            Icon(
                              Icons.stop,
                              color: Theme.of(context).colorScheme.onError,
                            ),
                            () => recordAudioVM.stopRecording((
                              String audioFilePath,
                            ) {
                              return showDialog(
                                context: context,
                                builder: (context) => Center(
                                  child: ConfirmSendModal(
                                    audioFilePath: audioFilePath,
                                  ),
                                ),
                              );
                            }),
                            disabled:
                                (recordAudioVM.recordState.value ==
                                RecordState.idle),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: Spacing.md),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Center(child: TimerValuePicker());
                          },
                        );
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Theme.of(
                            context,
                          ).colorScheme.surfaceContainerLow,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            "${recordAudioVM.secondsToStart}s",
                            style: Theme.of(context).textTheme.bodyLarge!
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
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
