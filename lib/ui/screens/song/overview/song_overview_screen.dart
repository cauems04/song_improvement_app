import 'dart:math';

import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/data/model/selected_song_provider.dart';
import 'package:guitar_song_improvement/themes/spacing.dart';
import 'package:guitar_song_improvement/ui/screens/choose_mode/choose_mode_screen.dart';
import 'package:provider/provider.dart';

class SongOverviewScreen extends StatelessWidget {
  const SongOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, right: 20, left: 20),
      child: SingleChildScrollView(
        child: Center(
          child: Consumer<SelectedSongProvider>(
            builder: (context, data, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    data.currentSong.name,
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: Text(
                      data.currentSong.artist,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  Text(
                    data.currentSong.album,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: Spacing.xl,
                      bottom: Spacing.lg,
                    ),
                    child: SizedBox(
                      height: 80,
                      child: ProgressGraphic(data.currentSong.reducedScore),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class ProgressGraphic extends StatefulWidget {
  final double progressValue;
  const ProgressGraphic(this.progressValue, {super.key});

  @override
  State<ProgressGraphic> createState() => _ProgressGraphicState();
}

class _ProgressGraphicState extends State<ProgressGraphic>
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
  void didUpdateWidget(covariant ProgressGraphic oldWidget) {
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
              painter: ProgressGraphicPainter(
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

class ProgressGraphicPainter extends CustomPainter {
  final double progress;
  final BuildContext context;

  const ProgressGraphicPainter(this.progress, this.context);

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
  bool shouldRepaint(ProgressGraphicPainter oldDelegate) =>
      oldDelegate.progress != progress;

  @override
  bool shouldRebuildSemantics(ProgressGraphicPainter oldDelegate) => true;
}
