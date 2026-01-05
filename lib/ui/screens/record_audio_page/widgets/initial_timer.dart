import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

class InitialTimer extends StatefulWidget {
  final int secondsToStart;
  const InitialTimer(this.secondsToStart, {super.key});

  @override
  State<InitialTimer> createState() => _InitialTimerState();
}

class _InitialTimerState extends State<InitialTimer> {
  late final Timer timer;
  late int countdownNumber;

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (countdownNumber < 1) return timer.cancel();

      setState(() => countdownNumber--);
    });
  }

  void startRecording() async {
    final AudioRecorder recorder = AudioRecorder();

    final Directory tempAudioDir = Directory(
      "${getTemporaryDirectory()}/tempAudioDir",
    );

    if (!await tempAudioDir.exists()) {
      await tempAudioDir.create(recursive: true);
    }

    final String fileName = "rec_${DateTime.now()}.m4a";
    final String tempPath = "${tempAudioDir.path}";
    recorder.start(const RecordConfig(), path: tempPath);
    // recorder.start(RecordConfig(), path: path)
  }

  @override
  void initState() {
    super.initState();

    countdownNumber = widget.secondsToStart;
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return (countdownNumber > 0)
        ? Text(
            countdownNumber.toString(),
            style: Theme.of(
              context,
            ).textTheme.displayLarge!.copyWith(fontWeight: FontWeight.bold),
          )
        : Text("...");
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }
}
