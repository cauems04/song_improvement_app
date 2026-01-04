import 'dart:async';

import 'package:flutter/material.dart';

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

  @override
  void initState() {
    super.initState();

    countdownNumber = widget.secondsToStart;
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      countdownNumber.toString(),
      style: Theme.of(
        context,
      ).textTheme.displayLarge!.copyWith(fontWeight: FontWeight.bold),
    );
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }
}
