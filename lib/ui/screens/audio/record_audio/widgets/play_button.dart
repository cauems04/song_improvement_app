import 'dart:math';

import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/ui/screens/audio/record_audio/view_models/record_audio_viewmodel.dart';
import 'package:guitar_song_improvement/ui/screens/audio/record_audio/widgets/initial_timer.dart';

class PlayButton extends StatefulWidget {
  final RecordAudioViewmodel recordAudioVM;

  const PlayButton({super.key, required this.recordAudioVM});

  @override
  State<PlayButton> createState() => _PlayButtonState();
}

class _PlayButtonState extends State<PlayButton>
    with SingleTickerProviderStateMixin {
  late AnimationController buttonController;

  @override
  void initState() {
    buttonController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 4),
    );
    super.initState();
  }

  @override
  void didUpdateWidget(PlayButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.recordAudioVM.recordState.value == RecordState.recording) {
      buttonController.repeat();
      return;
    }

    buttonController.animateTo(0);
    buttonController.stop();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.recordAudioVM.handlePlayButtonAction();
      },
      child: RotationTransition(
        turns: buttonController,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 400),
          alignment: Alignment.center,
          width:
              (widget.recordAudioVM.recordState.value ==
                      RecordState.recording ||
                  widget.recordAudioVM.recordState.value == RecordState.paused)
              ? 100
              : 250,
          height:
              (widget.recordAudioVM.recordState.value ==
                      RecordState.recording ||
                  widget.recordAudioVM.recordState.value == RecordState.paused)
              ? 100
              : 250,
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.center,
              colors:
                  (widget.recordAudioVM.recordState.value ==
                          RecordState.recording ||
                      widget.recordAudioVM.recordState.value ==
                          RecordState.paused)
                  ? [
                      Theme.of(context).colorScheme.onPrimary,
                      Theme.of(context).colorScheme.primary,
                    ]
                  : [
                      Theme.of(context).colorScheme.surfaceContainerLow,
                      Theme.of(context).colorScheme.surfaceContainerLowest,
                    ],
            ),
            // color: (recordState == RecordState.countdown)
            //     ? Theme.of(context).colorScheme.primary
            //     : Theme.of(context).colorScheme.surfaceContainerLowest,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 3),
          ),
          child:
              (widget.recordAudioVM.recordState.value == RecordState.countdown)
              ? InitialTimer(widget.recordAudioVM)
              : Icon(
                  (widget.recordAudioVM.recordState.value ==
                              RecordState.recording ||
                          widget.recordAudioVM.recordState.value ==
                              RecordState.paused)
                      ? Icons.refresh_sharp
                      : Icons.mic,
                  size:
                      (widget.recordAudioVM.recordState.value ==
                              RecordState.recording ||
                          widget.recordAudioVM.recordState.value ==
                              RecordState.paused)
                      ? 40
                      : 80,
                ),
        ),
      ),
    );
  }
}

class PlayAnimation extends StatefulWidget {
  const PlayAnimation({super.key});

  @override
  State<PlayAnimation> createState() => _PlayAnimationState();
}

class _PlayAnimationState extends State<PlayAnimation>
    with TickerProviderStateMixin {
  late final AnimationController circlePulseController;

  late final AnimationController ringsPulseController;

  @override
  void initState() {
    super.initState();

    final Duration duration = Duration(milliseconds: 400);

    circlePulseController = AnimationController(
      vsync: this,
      lowerBound: 0,
      upperBound: 1,
      duration: duration,
    );

    ringsPulseController = AnimationController(
      vsync: this,
      lowerBound: 0,
      upperBound: 1,
      duration: duration * 4,
    );

    circlePulseController.repeat(reverse: true);
    ringsPulseController.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        circlePulseController,
        ringsPulseController,
      ]),
      builder: (context, child) {
        return CustomPaint(
          painter: _PlayAnimationPainter(
            color: Theme.of(context).colorScheme.onPrimary,
            circlePulse: circlePulseController.value,
            ringsPulse: ringsPulseController.value,
          ),
          size: Size(200, 200),
        );
      },
    );
  }
}

class _PlayAnimationPainter extends CustomPainter {
  // final List<Animation<double>> animations;
  final Color color;
  final double circlePulse;
  final double ringsPulse;

  _PlayAnimationPainter({
    required this.circlePulse,
    required this.ringsPulse,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Offset centerOffset = Offset(size.width / 2, size.height / 2);
    final double baseRadius = size.width / 20;

    Paint circlePainter = Paint()
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round
      ..color = color;

    canvas.drawCircle(
      centerOffset,
      baseRadius + (baseRadius * 0.5 * circlePulse),
      circlePainter,
    );

    final List<double> ringRadius = [
      baseRadius * 5.0,
      baseRadius * 8.0,
      baseRadius * 11.0,
    ];
    final delays = [0.0, 0.2, 0.4];

    for (int i = 0; i < ringRadius.length; i++) {
      final offset = (ringsPulse - delays[i]) % 1.0;
      final curved = (sin(offset * 2 * pi - pi / 2) + 0.6) / 2;
      final opacity = 0.3 + (0.7 * curved);
      final animatedRadius = ringRadius[i] * (0.8 + (0.2 * curved));

      canvas.drawCircle(
        centerOffset,
        animatedRadius,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2
          ..color = color.withValues(alpha: opacity),
      );
    }
  }

  @override
  bool shouldRepaint(_PlayAnimationPainter oldDelegate) =>
      (oldDelegate.circlePulse != circlePulse ||
      oldDelegate.ringsPulse != ringsPulse);

  @override
  bool shouldRebuildSemantics(_PlayAnimationPainter oldDelegate) => false;
}
