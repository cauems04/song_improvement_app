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
      duration: Duration(milliseconds: 400),
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
    final double shimmerLength = size.width * 0.3;

    final double shimmerX =
        (animationProgress * (size.width + shimmerLength)) - shimmerLength;

    final List<Color> gradient = [
      Colors.transparent,
      Colors.white.withAlpha(120),
      Colors.transparent,
    ];

    if (animationProgress < 0.1)
      print(
        'shimmerXaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa: $shimmerX, progress: $animationProgress',
      );

    final Paint paint = Paint()
      ..style = PaintingStyle.fill
      ..shader = ui.Gradient.linear(
        Offset(shimmerX, 0),
        Offset(shimmerX + shimmerLength, size.height),
        gradient,
        [0.0, 0.5, 1.0],
      );

    canvas.drawRect(Offset.zero & size, paint);
  }

  @override
  bool shouldRepaint(_ShimmerPainter oldDelegate) =>
      oldDelegate.animationProgress != animationProgress;

  @override
  bool shouldRebuildSemantics(_ShimmerPainter oldDelegate) => false;
}
