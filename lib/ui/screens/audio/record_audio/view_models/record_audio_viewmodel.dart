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

  Timer? timer;
  late ValueNotifier<int> countdownNumber;

  Timer? recordingTimer;
  late ValueNotifier<int> recordingSeconds;

  String? _audioFilePath;

  late final AudioRecorder _recorder;

  void initValues() {
    recordState = ValueNotifier(RecordState.idle);
    secondsToStart = 2; // Implement with caching later
    _recorder = AudioRecorder();
    countdownNumber = ValueNotifier(secondsToStart);
    recordingSeconds = ValueNotifier(0);
  }

  void startCountdown() {
    countdownNumber.value = secondsToStart;
    recordState.value = RecordState.countdown;
    timer = startTimer();
  }

  Future<void> _startRecording() async {
    Directory tempAudioDirectory = await getTemporaryDirectory();

    tempAudioDirectory = Directory("${tempAudioDirectory.path}/tempAudioDir");

    if (!await tempAudioDirectory.exists()) {
      await tempAudioDirectory.create(recursive: true);
    }

    final String fileName = "rec_${DateTime.now()}.m4a";
    final String filePath = '${tempAudioDirectory.path}/$fileName';

    _recorder.start(const RecordConfig(), path: filePath);

    recordingTimer?.cancel();
    recordingSeconds.value = 0;
    recordingTimer = Timer.periodic(
      Duration(seconds: 1),
      (timer) => recordingSeconds.value++,
    );

    _audioFilePath = filePath;
    recordState.value = RecordState.recording;
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
  Future<void> stopRecording() async {
    await _recorder.stop();

    // Creating model to check whether to save it or discard , and create the remaining code based on it,
    // setting it to idle or saved
    print(".\n.\n.\n.\nstoping....\n.\n.\n.\n");
    recordState.value = RecordState.idle;
  }

  Future<void> handlePlayButtonAction<T>(
    Future<T?> Function(String filePath) showDialog,
  ) async {
    if (recordState.value == RecordState.idle) {
      startCountdown();
    } else {
      stopRecording();
      showDialog(_audioFilePath!);
    }
  }

  Future<void> cancelRecord() async {
    timer?.cancel();
    recordingTimer?.cancel();
    recordingSeconds.value = 0;
    countdownNumber.value = secondsToStart;
    await _recorder.cancel();
  }

  Timer startTimer() {
    return Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (countdownNumber.value < 1) {
        timer.cancel();
        _startRecording();
        return;
      }

      countdownNumber.value--;
    });
  }
}
