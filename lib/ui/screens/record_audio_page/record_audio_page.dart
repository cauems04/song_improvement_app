import 'dart:io';

import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/themes/spacing.dart';
import 'package:guitar_song_improvement/ui/screens/record_audio_page/widgets/play_button.dart';
import 'package:guitar_song_improvement/ui/screens/record_audio_page/widgets/time_value_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

class RecordAudioPage extends StatefulWidget {
  const RecordAudioPage({super.key});

  @override
  State<RecordAudioPage> createState() => _RecordAudioPageState();
}

enum RecordState { idle, countdown, recording, paused }

class _RecordAudioPageState extends State<RecordAudioPage> {
  late RecordState recordState;
  late int secondsToStart;

  late final AudioRecorder recorder;

  @override
  void initState() {
    super.initState();

    recordState = RecordState.idle;
    secondsToStart = 2; // Implement with caching later
    recorder = AudioRecorder();
  }

  void startCountdown() {
    setState(() {
      recordState = RecordState.countdown;
    });
  }

  Future<void> startRecording() async {
    final Directory tempAudioDir = Directory(
      "${getTemporaryDirectory()}/tempAudioDir",
    );

    if (!await tempAudioDir.exists()) {
      await tempAudioDir.create(recursive: true);
    }

    final String fileName = "rec_${DateTime.now()}.m4a";
    final String tempPath = "${tempAudioDir.path}";

    recorder.start(const RecordConfig(), path: tempPath);

    setState(() {
      recordState = RecordState.recording;
    });
  }

  // Probably using it outside the PlayButton, with another button, no need to pass via parameter
  Future<void> stopRecording() async {
    await recorder.stop();

    // Creating model to check whether to save it or discard , and create the remaining code based on it,
    // setting it to idle or saved
    setState(() {
      recordState = RecordState.idle;
    });
  }

  Future<void> restartRecording() async {
    // Can also use cancel to check if user wants to stop recording or cancel it, so we wouldn't have to delete the temp file by this page
    await recorder.cancel();

    startCountdown();
  }

  // Probably using it outside the PlayButton, with another button
  Future<void> pauseResumeRecording() async {
    (recordState == RecordState.paused)
        ? await recorder.resume()
        : await recorder.pause();

    // Creating model to check whether to save it or discard , and create the remaining code based on it,
    // setting it to idle or saved
    setState(() {
      recordState = (recordState == RecordState.paused)
          ? RecordState.recording
          : RecordState.paused;
    });
  }

  Future<void> handlePlayButtonAction() async {
    switch (recordState) {
      case RecordState.idle:
        startCountdown();
        break;

      case RecordState.countdown:
        // await stopCountdown() or restartCountdown;
        break;

      case RecordState.recording:
        await restartRecording();
        break;

      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        padding: const EdgeInsets.all(Spacing.md),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: PlayButton(
                recordState: recordState,
                secondsToStart: secondsToStart,
                onPressed: handlePlayButtonAction,
                onInitialCountFinished: startRecording,
              ),
            ),
            SafeArea(
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
                          "${secondsToStart}s",
                          style: Theme.of(context).textTheme.bodyLarge!
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
