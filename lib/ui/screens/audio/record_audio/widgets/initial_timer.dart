import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/ui/screens/audio/record_audio/view_models/record_audio_viewmodel.dart';

class InitialTimer extends StatefulWidget {
  final RecordAudioViewmodel recordAudioVM;

  const InitialTimer(this.recordAudioVM, {super.key});

  @override
  State<InitialTimer> createState() => _InitialTimerState();
}

class _InitialTimerState extends State<InitialTimer> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.recordAudioVM.countdownNumber,
      builder: (context, value, child) {
        return AnimatedSwitcher(
          duration: Duration(milliseconds: 300),
          layoutBuilder: (currentChild, previousChildren) {
            return Stack(
              alignment: Alignment.center,
              children: [
                ...previousChildren,
                if (currentChild != null) currentChild,
              ],
            );
          },
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: ScaleTransition(
                scale: Tween(begin: 0.0, end: 1.0).animate(
                  CurvedAnimation(parent: animation, curve: Curves.easeOut),
                ),
                child: child,
              ),
            );
          },
          child: Text(
            widget.recordAudioVM.countdownNumber.value.toString(),
            key: ValueKey(widget.recordAudioVM.countdownNumber.value),
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
              fontSize: 30,
              fontWeight: FontWeight.w600,
              letterSpacing: 4,
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    widget.recordAudioVM.timer?.cancel();
  }
}
