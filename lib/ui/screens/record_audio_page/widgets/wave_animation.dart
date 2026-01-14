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
      upperBound: 1,
    );

    waveControler.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: waveControler,
      builder: (context, child) {
        return CustomPaint(painter: WavePainter(context, waveControler.value));
      },
    );
  }
}

class WavePainter extends CustomPainter {
  final BuildContext context;
  final double animationValue;

  const WavePainter(this.context, this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint painter = Paint()
      ..style = PaintingStyle.stroke
      ..color = Theme.of(context).colorScheme.onPrimary;

    Path path = Path()..moveTo(0, size.height / 2);

    for (int i = 1; i <= 30; i++) {
      path.lineTo(
        i * size.width / 30,
        size.height / 2 + sin(animationValue + 1 * pi / 15) * 20,
      );
    }

    path.lineTo(size.width, size.height / 2);

    canvas.drawPath(path, painter);
  }

  @override
  bool shouldRepaint(WavePainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(WavePainter oldDelegate) => false;
}
