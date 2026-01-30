import 'dart:math';

import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/data/model/selected_song_provider.dart';
import 'package:guitar_song_improvement/ui/screens/choose_mode/choose_mode_screen.dart';
import 'package:provider/provider.dart';

class ProgressGraph extends StatefulWidget {
  final double progressValue;
  const ProgressGraph(this.progressValue, {super.key});

  @override
  State<ProgressGraph> createState() => _ProgressGraphState();
}

class _ProgressGraphState extends State<ProgressGraph>
    with SingleTickerProviderStateMixin {
  // change to not single ticker provider
  late AnimationController progressController;
  late Animation<double> curvedProgressController;

  @override
  void initState() {
    progressController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 4),
      lowerBound: 0,
      upperBound: 1,
    );

    curvedProgressController = CurvedAnimation(
      parent: progressController,
      curve: Curves.easeOut,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      progressController.animateTo(widget.progressValue);
    });

    super.initState();
  }

  @override
  void didUpdateWidget(covariant ProgressGraph oldWidget) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      progressController.reset();
      progressController.animateTo(widget.progressValue);
    });
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: curvedProgressController,
      builder: (context, widget) => Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: ProgressGraphPainter(
                curvedProgressController.value,
                context,
              ),
            ),
          ),
          Center(
            child: IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (newContext) => ChangeNotifierProvider.value(
                      value: Provider.of<SelectedSongProvider>(context),
                      child: ChooseModeScreen(),
                    ),
                  ),
                );
              },
              icon: Icon(Icons.play_arrow, size: 50),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    progressController.dispose();
    super.dispose();
  }
}

class ProgressGraphPainter extends CustomPainter {
  final double progress;
  final BuildContext context;

  const ProgressGraphPainter(this.progress, this.context);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint painter = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.height / 6
      ..color = Colors.greenAccent;

    final Paint basePainter = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.height / 6
      ..color = Theme.of(context).colorScheme.surfaceContainerLowest;

    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.height / 2,
      basePainter,
    );

    canvas.drawArc(
      Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: size.height / 2,
      ),
      (-pi / 2),
      (2 * pi * progress),
      false,
      painter,
    );
  }

  @override
  bool shouldRepaint(ProgressGraphPainter oldDelegate) =>
      oldDelegate.progress != progress;

  @override
  bool shouldRebuildSemantics(ProgressGraphPainter oldDelegate) => true;
}
