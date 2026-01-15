import 'dart:math';

import 'package:flutter/material.dart';

class WaveAnimation extends StatefulWidget {
  const WaveAnimation({super.key});

  @override
  State<WaveAnimation> createState() => _WaveAnimationState();
}

class _WaveAnimationState extends State<WaveAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController waveControler;

  @override
  void initState() {
    super.initState();

    waveControler = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
      lowerBound: 0,
      upperBound: 2 * pi,
    );

    waveControler.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: waveControler,
      builder: (context, child) {
        return CustomPaint(
          painter: WavePainter(context, waveControler.value),
          size: Size.infinite,
        );
      },
    );
  }

  @override
  void dispose() {
    waveControler.dispose();
    super.dispose();
  }
}

class WavePainter extends CustomPainter {
  final BuildContext context;
  final double animationValue;

  const WavePainter(this.context, this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..color = Theme.of(context).colorScheme.onPrimary;

    final midY = size.height / 2;
    const amplitude = 20.0;
    const frequency = pi / 15;

    final path = Path()..moveTo(0, midY + sin(animationValue) * amplitude);

    for (int i = 1; i <= 30; i++) {
      final x = i * size.width / 30;
      final y = midY + sin(animationValue + i * frequency) * amplitude;
      path.lineTo(x, y);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(WavePainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(WavePainter oldDelegate) => false;
}
