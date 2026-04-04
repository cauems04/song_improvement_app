import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:guitar_song_improvement/themes/spacing.dart';
import 'package:guitar_song_improvement/ui/screens/analysis/auto_analysis/content/rate_info.dart';
import 'package:guitar_song_improvement/ui/screens/analysis/auto_analysis/content/score_type.dart';
import 'package:guitar_song_improvement/ui/screens/analysis/auto_analysis/widgets/score_card.dart';

class ScoreRateBox extends StatefulWidget {
  final RateType rateType;

  const ScoreRateBox({super.key, required this.rateType});

  @override
  State<ScoreRateBox> createState() => _ScoreRateBoxState();
}

class _ScoreRateBoxState extends State<ScoreRateBox> {
  late List<ScoreType> receivedScoreTypes;
  late final Color rateColor;
  late final Color baseColor;

  @override
  void initState() {
    super.initState();
    receivedScoreTypes = [];
    rateColor = rateColors[widget.rateType]!;
    baseColor = Colors.white54;
  }

  @override
  Widget build(BuildContext context) {
    return DragTarget<ScoreType>(
      onAcceptWithDetails: (DragTargetDetails<ScoreType> details) {
        setState(() {
          receivedScoreTypes.add(details.data);
        });
      },
      builder: (context, candidateData, rejectedData) {
        return Container(
          padding: const EdgeInsets.symmetric(
            vertical: Spacing.xs,
            horizontal: Spacing.sm,
          ),
          width: double.infinity,
          decoration: BoxDecoration(
            color: (candidateData.isEmpty)
                ? baseColor.withAlpha(30)
                : rateColor.withAlpha(30),
            border: Border.all(
              color: (candidateData.isEmpty)
                  ? baseColor.withAlpha(120)
                  : rateColor.withAlpha(120),
            ),
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
