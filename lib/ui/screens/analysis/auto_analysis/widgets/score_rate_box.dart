import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/themes/spacing.dart';
import 'package:guitar_song_improvement/ui/screens/analysis/auto_analysis/content/drag_card_data.dart';
import 'package:guitar_song_improvement/ui/screens/analysis/auto_analysis/content/rate_info.dart';
import 'package:guitar_song_improvement/ui/screens/analysis/auto_analysis/content/score_type.dart';
import 'package:guitar_song_improvement/ui/screens/analysis/auto_analysis/view_models/auto_analysis_viewmodel.dart';
import 'package:guitar_song_improvement/ui/screens/analysis/auto_analysis/widgets/score_card.dart';

class ScoreRateBox extends StatefulWidget {
  final GlobalKey boxKey;
  final RateType rateType;
  final AutoAnalysisViewModel autoAnalysisVM;

  const ScoreRateBox({
    super.key,
    required this.rateType,
    required this.boxKey,
    required this.autoAnalysisVM,
  });

  @override
  State<ScoreRateBox> createState() => _ScoreRateBoxState();
}

class _ScoreRateBoxState extends State<ScoreRateBox> {
  late List<ScoreType> receivedScoreTypes;
  late final Color rateColor;
  late final Color baseColor;

  late final OverlayEntry overlayEntry;

  @override
  void initState() {
    super.initState();
    receivedScoreTypes = [];
    rateColor = rateColors[widget.rateType]!;
    baseColor = Colors.white54;
  }

  Offset getNextAvailableCardPosition() {
    final RenderBox renderBox =
        widget.boxKey.currentContext!.findRenderObject() as RenderBox;
    final Offset boxPosition = renderBox.localToGlobal(Offset.zero);

    print("boxPosition: $boxPosition");
    print("receivedScoreTypes.length: ${receivedScoreTypes.length}");

    const double cardWidth = 50;
    const double spacing = Spacing.sm;
    const double paddingLeft = Spacing.sm;

    final double nextX =
        boxPosition.dx +
        paddingLeft +
        (receivedScoreTypes.length * (cardWidth + spacing));
    final double nextY =
        boxPosition.dy + 30; // altura do texto do título aproximadamente

    print("nextPosition: ${Offset(nextX, nextY)}");

    return Offset(nextX, nextY);
  }

  Color getBorderColor(List<DragCardData?> candidateData) {
    if (candidateData.isNotEmpty) {
      return rateColor.withAlpha(200);
    } else if (receivedScoreTypes.isNotEmpty) {
      return rateColor.withAlpha(140);
    }
    return baseColor.withAlpha(60);
  }

  Color getBackgroundColor(List<DragCardData?> candidateData) {
    if (candidateData.isNotEmpty) {
      return rateColor.withAlpha(80);
    } else if (receivedScoreTypes.isNotEmpty) {
      return rateColor.withAlpha(45);
    }
    return baseColor.withAlpha(15);
  }

  @override
  Widget build(BuildContext context) {
    return DragTarget<DragCardData>(
      key: widget.boxKey,
      onAcceptWithDetails: (DragTargetDetails<DragCardData> details) async {
        final targetPosition = getNextAvailableCardPosition();

        final Completer completer = Completer<void>();

        widget.autoAnalysisVM.setAnimating(true);

        late final OverlayEntry overlayEntry;
        overlayEntry = OverlayEntry(
          builder: (context) => CardPlacingAnimation(
            cardData: details.data,
            cardFinalSize: Size(0, 0),
            initialPosition: details.offset,
            finalPosition: targetPosition,
            onAnimationEnd: () {
              overlayEntry.remove();
              completer.complete();
            },
          ),
        );

        Overlay.of(context).insert(overlayEntry);

        await completer.future;

        receivedScoreTypes.add(details.data.scoreType);
        widget.autoAnalysisVM.changeNextScoreType();
      },
      builder: (context, candidateData, rejectedData) {
        return Container(
          padding: const EdgeInsets.symmetric(
            vertical: Spacing.xs,
            horizontal: Spacing.sm,
          ),
          width: double.infinity,
          decoration: BoxDecoration(
            color: getBackgroundColor(candidateData),
            border: Border.all(color: getBorderColor(candidateData)),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.rateType.name,
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 70,
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: receivedScoreTypes.length,
                  separatorBuilder: (context, index) =>
                      SizedBox(width: Spacing.sm),
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: 50,
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: ScoreCard(scoreType: receivedScoreTypes[index]),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class CardPlacingAnimation extends StatefulWidget {
  final DragCardData cardData;
  final Size cardFinalSize;
  final Offset initialPosition;
  final Offset finalPosition;
  final VoidCallback onAnimationEnd;

  const CardPlacingAnimation({
    super.key,
    required this.cardData,
    required this.initialPosition,
    required this.finalPosition,
    required this.cardFinalSize,
    required this.onAnimationEnd,
  });

  @override
  State<CardPlacingAnimation> createState() => _CardPlacingAnimationState();
}

class _CardPlacingAnimationState extends State<CardPlacingAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController transitionController;
  late final CurvedAnimation curvedTransitionAnimation;

  @override
  void initState() {
    super.initState();

    transitionController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );

    curvedTransitionAnimation = CurvedAnimation(
      parent: transitionController,
      curve: Curves.easeOutQuart,
    );

    transitionController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onAnimationEnd();
      }
    });

    transitionController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: curvedTransitionAnimation,
      builder: (context, child) {
        final Offset currentPosition = Offset.lerp(
          widget.initialPosition,
          widget.finalPosition,
          curvedTransitionAnimation.value,
        )!;

        final Size currentSize = Size.lerp(
          widget.cardData.size,
          Size(50, 70),
          curvedTransitionAnimation.value,
        )!;

        return Positioned(
          left: currentPosition.dx,
          top: currentPosition.dy,

          child: SizedBox(
            width: currentSize.width,
            height: currentSize.height,
            child: FittedBox(
              fit: BoxFit.contain,
              child: ScoreCard(scoreType: widget.cardData.scoreType),
            ),
          ),
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
