import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

enum RecordState { idle, countdown, recording, paused }

class RecordAudioViewmodel extends ChangeNotifier {
  late ValueNotifier<RecordState> recordState;
  late int secondsToStart;
  late void Function() a;

  late Timer timer;
  late ValueNotifier<int> countdownNumber;

  late final AudioRecorder _recorder;

  void initValues() {
    recordState = ValueNotifier(RecordState.idle);
    secondsToStart = 2; // Implement with caching later
    _recorder = AudioRecorder();
  }

  void initTimer() {
    countdownNumber = ValueNotifier(secondsToStart);
    timer = startTimer();
  }

  void startCountdown() {
    print(".\n.\n.\n.\ncounting....\n.\n.\n.\n");
    recordState.value = RecordState.countdown;
  }

  Future<void> startRecording() async {
    Directory tempAudioDir = await getTemporaryDirectory();

    tempAudioDir = Directory("${tempAudioDir.path}/tempAudioDir");

    if (!await tempAudioDir.exists()) {
      await tempAudioDir.create(recursive: true);
    }

    final String fileName = "rec_${DateTime.now()}.m4a";
    final String filePath = '${tempAudioDir.path}/$fileName';

    _recorder.start(const RecordConfig(), path: filePath);

    print(".\n.\n.\n.\nrecording....\n.\n.\n.\n");
    recordState.value = RecordState.recording;
    ;
  }

  Future<void> restartRecording() async {
    // Can also use cancel to check if user wants to stop recording or cancel it, so we wouldn't have to delete the temp file by this page
    await cancelRecord();

    startCountdown();
  }

  // Probably using it outside the PlayButton, with another button
  Future<void> pauseResumeRecording() async {
    (recordState.value == RecordState.paused)
        ? await _recorder.resume()
        : await _recorder.pause();

    // Creating model to check whether to save it or discard , and create the remaining code based on it,
    // setting it to idle or saved
    recordState.value = (recordState.value == RecordState.paused)
        ? RecordState.recording
        : RecordState.paused;
  }

  // Probably using it outside the PlayButton, with another button, no need to pass via parameter
  Future<void> stopRecording<T>(Future<T?> Function() showDialog) async {
    await _recorder.stop();

    showDialog();

    // Creating model to check whether to save it or discard , and create the remaining code based on it,
    // setting it to idle or saved
    print(".\n.\n.\n.\nstoping....\n.\n.\n.\n");
    recordState.value = RecordState.idle;
  }

  Future<void> handlePlayButtonAction() async {
    switch (recordState.value) {
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

  Future<void> cancelRecord() async {
    _recorder.cancel();
  }

  Timer startTimer() {
    return Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (countdownNumber.value < 1) {
        timer.cancel();
        startRecording();
        return;
      }

      countdownNumber.value--;
    });
  }
}
