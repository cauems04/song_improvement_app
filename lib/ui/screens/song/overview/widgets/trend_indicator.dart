import 'package:flutter/material.dart';

enum Trend { up, down, flat }

class TrendIndicator extends StatelessWidget {
  final Trend trend;
  late Color color;
  TrendIndicator({super.key, required this.trend}) {
    color = switch (trend) {
      Trend.up => Colors.greenAccent,
      Trend.down => Colors.redAccent,
      Trend.flat => Colors.blueAccent,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 6),
      decoration: BoxDecoration(
        color: color.withAlpha(60),
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(
        switch (trend) {
          Trend.up => Icons.trending_up,
          Trend.down => Icons.trending_down,
          Trend.flat => Icons.trending_flat,
        },
        color: Colors.white,
        size: 18,
      ),
    );
  }
}
