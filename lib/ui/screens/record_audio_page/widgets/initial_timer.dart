import 'dart:async';
import 'package:flutter/material.dart';

class InitialTimer extends StatefulWidget {
  final int secondsToStart;
  final VoidCallback onFinished;

  const InitialTimer(this.secondsToStart, this.onFinished, {super.key});

  @override
  State<InitialTimer> createState() => _InitialTimerState();
}

class _InitialTimerState extends State<InitialTimer> {
  late final Timer timer;
  late int countdownNumber;

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (countdownNumber < 1) {
        timer.cancel();
        widget.onFinished();
        return;
      }

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
    return Stack(
      children: [
        (countdownNumber > 0)
            ? Text(
                countdownNumber.toString(),
                style: Theme.of(
                  context,
                ).textTheme.displayLarge!.copyWith(fontWeight: FontWeight.bold),
              )
            : Text("..."),
        Material(
          // Adjust button, it's not realiable as a stack in here, and I want it outside the button circle, so need to find a way to get this outside (at least visually)
          color: Colors.white24,
          shape: CircleBorder(),
          child: InkWell(
            customBorder: CircleBorder(),
            onTap: () {},
            child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(shape: BoxShape.circle),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }
}
