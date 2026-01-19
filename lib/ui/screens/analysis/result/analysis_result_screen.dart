import 'package:flutter/material.dart';

class AnalysisResultScreen extends StatefulWidget {
  final int score;
  const AnalysisResultScreen(this.score, {super.key});

  @override
  State<AnalysisResultScreen> createState() => _AnalysisResultScreenState();
}

class _AnalysisResultScreenState extends State<AnalysisResultScreen>
    with TickerProviderStateMixin {
  late AnimationController titleOpacityController;

  late AnimationController scoreBackgroundSizeController;
  late CurvedAnimation scoreBackgroundSizeCurvedController;

  @override
  void initState() {
    titleOpacityController = AnimationController(
      vsync: this,
      lowerBound: 0,
      upperBound: 1,
      duration: Duration(seconds: 1),
    );

    scoreBackgroundSizeController = AnimationController(
      vsync: this,
      lowerBound: 0.5,
      upperBound: 1,
      duration: Duration(seconds: 3),
    );

    scoreBackgroundSizeCurvedController = CurvedAnimation(
      parent: scoreBackgroundSizeController,
      curve: Curves.ease,
    );

    titleOpacityController.animateTo(1);
    scoreBackgroundSizeController.repeat(reverse: true);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: AlignmentGeometry.topCenter,
            end: AlignmentGeometry.bottomCenter,
            colors: [
              Colors.deepPurple[900]!,
              Colors.purple[900]!,
              Theme.of(context).colorScheme.onPrimary,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FadeTransition(
                opacity: titleOpacityController,
                child: Text(
                  "Your Score",
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Stack(
                alignment: AlignmentGeometry.center,
                children: [
                  ScaleTransition(
                    scale: scoreBackgroundSizeCurvedController,
                    child: Container(
                      height: 260,
                      width: 260,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white70, width: 2),
                      ),
                    ),
                  ),
                  ScaleTransition(
                    scale: scoreBackgroundSizeCurvedController,
                    child: Container(
                      height: 220,
                      width: 220,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromRGBO(0, 0, 0, 0.4),
                      ),
                    ),
                  ),
                  Text(
                    widget.score.toString(),
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Text(
                "Personalized Text",
                style: Theme.of(
                  context,
                ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w600),
              ),
              _ConfirmButtom(widget.score),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    titleOpacityController.dispose();

    scoreBackgroundSizeController.dispose();
    scoreBackgroundSizeCurvedController.dispose();
    super.dispose();
  }
}

class _ConfirmButtom extends StatelessWidget {
  final int score;

  const _ConfirmButtom(this.score);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        child: SizedBox(
          height: 50,
          width: 300,
          // decoration: BoxDecoration(boxShadow: [BoxShadow()]),
          child: Center(
            child: Text(
              "Confirm",
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
