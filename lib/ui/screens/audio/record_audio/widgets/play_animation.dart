import 'dart:math';

import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/ui/screens/audio/record_audio/view_models/record_audio_viewmodel.dart';

class PlayAnimation extends StatefulWidget {
  final RecordState state;

  const PlayAnimation({super.key, required this.state});

  @override
  State<PlayAnimation> createState() => _PlayAnimationState();
}

class _PlayAnimationState extends State<PlayAnimation>
    with TickerProviderStateMixin {
  late final AnimationController circlePulseController;
  late final AnimationController ringsPulseController;

  bool isAnimating = false;

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
  }

  @override
  void didUpdateWidget(covariant PlayAnimation oldWidget) {
    if (oldWidget.state == widget.state) return;
    super.didUpdateWidget(oldWidget);

    if (widget.state == RecordState.recording) {
      circlePulseController.repeat(reverse: true);
      ringsPulseController.repeat();
    } else {
      circlePulseController.stop();
      ringsPulseController.stop();
    }
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
          size: Size.infinite,
        );
      },
    );
  }

  @override
  void dispose() {
    circlePulseController.dispose();
    ringsPulseController.dispose();
    super.dispose();
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

// import 'dart:math';

// import 'package:flutter/material.dart';

// class WaveAnimation extends StatefulWidget {
//   const WaveAnimation({super.key});

//   @override
//   State<WaveAnimation> createState() => _WaveAnimationState();
// }

// class _WaveAnimationState extends State<WaveAnimation>
//     with SingleTickerProviderStateMixin {
//   late AnimationController waveControler;

//   @override
//   void initState() {
//     super.initState();

//     waveControler = AnimationController(
//       vsync: this,
//       duration: Duration(seconds: 1),
//       lowerBound: 0,
//       upperBound: 2 * pi,
//     );

//     waveControler.repeat();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: waveControler,
//       builder: (context, child) {
//         return CustomPaint(
//           painter: WavePainter(context, waveControler.value),
//           size: Size.infinite,
//         );
//       },
//     );
//   }

//   @override
//   void dispose() {
//     waveControler.dispose();
//     super.dispose();
//   }
// }

// class WavePainter extends CustomPainter {
//   final BuildContext context;
//   final double animationValue;

//   const WavePainter(this.context, this.animationValue);

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 4
//       ..color = Theme.of(context).colorScheme.onPrimary;

//     final midY = size.height / 2;
//     const amplitude = 20.0;
//     const frequency = pi / 15;

//     final path = Path()..moveTo(0, midY + sin(animationValue) * amplitude);

//     for (int i = 1; i <= 30; i++) {
//       final x = i * size.width / 30;
//       final y = midY + sin(animationValue + i * frequency) * amplitude;
//       path.lineTo(x, y);
//     }

//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(WavePainter oldDelegate) => true;

//   @override
//   bool shouldRebuildSemantics(WavePainter oldDelegate) => false;
// }
