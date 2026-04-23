import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class StarterShimmer extends StatefulWidget {
  final Widget child;

  const StarterShimmer({super.key, required this.child});

  @override
  State<StarterShimmer> createState() => _StarterShimmerState();
}

class _StarterShimmerState extends State<StarterShimmer>
    with SingleTickerProviderStateMixin {
  late final AnimationController transitionController;

  @override
  void initState() {
    super.initState();
    print('StarterShimmer initStateeeeeeeeeeeeeeeeeeeeeeeeeeeeeee');
    transitionController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );

    Future.delayed(Duration(milliseconds: 100), () {
      if (mounted) transitionController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: transitionController,
      child: widget.child,
      builder: (context, child) {
        return CustomPaint(
          foregroundPainter: _ShimmerPainter(transitionController.value),
          child: child,
        );
      },
    );
  }

  @override
  void dispose() {
    transitionController.dispose();
    super.dispose();
  }
}

class _ShimmerPainter extends CustomPainter {
  final double animationProgress;

  const _ShimmerPainter(this.animationProgress);

  @override
  void paint(Canvas canvas, Size size) {
    final double diagonal = sqrt(
      size.width * size.width + size.height * size.height,
    );
    final double shimmerLength = diagonal * 0.4;

    final double shimmerX =
        (animationProgress * (size.width + shimmerLength * 2)) - shimmerLength;
    final double shimmerY =
        (animationProgress * (size.height + shimmerLength * 2)) - shimmerLength;

    print('shimmerX: $shimmerX, shimmerLength: $shimmerLength, size: $size');

    final List<Color> gradient = [
      Colors.white.withAlpha(0),
      Colors.white.withAlpha(180),
      Colors.white.withAlpha(0),
    ];

    final Paint paint = Paint()
      ..style = PaintingStyle.fill
      ..shader = ui.Gradient.linear(
        Offset(shimmerX, shimmerY),
        Offset(shimmerX + shimmerLength, shimmerY + shimmerLength),
        gradient,
        [0.0, 0.5, 1.0],
      );

    canvas.drawRRect(
      RRect.fromRectAndRadius(Offset.zero & size, Radius.circular(10)),
      paint,
    );
  }

  @override
  bool shouldRepaint(_ShimmerPainter oldDelegate) =>
      oldDelegate.animationProgress != animationProgress;

  @override
  bool shouldRebuildSemantics(_ShimmerPainter oldDelegate) => false;
}
