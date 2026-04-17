import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/themes/dark_theme.dart';
import 'package:guitar_song_improvement/themes/spacing.dart';
import 'package:guitar_song_improvement/ui/widgets/starter_shimmer.dart';

class DatePlayedCard extends StatelessWidget {
  final DateTime dateCreation;
  late bool isRecent;
  late Color cardColor;
  DatePlayedCard({super.key, required this.dateCreation}) {
    isRecent = (DateTime.now().difference(dateCreation).inDays >= 7)
        ? false
        : true;

    cardColor = (isRecent) ? Colors.greenAccent : DarkThemeColors.alert;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [cardColor.withAlpha(20), cardColor.withAlpha(60)],
        ),
        border: Border.all(color: cardColor),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Spacing.md),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: Spacing.sm),
              child: CircleAvatar(
                radius: 28,
                backgroundColor: cardColor.withAlpha(70),
                child: Icon(Icons.queue_music, color: cardColor),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    (isRecent) ? "Played recently" : "No recent practice",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  "Last at ${dateCreation.year}/${dateCreation.month.toString().padLeft(2, '0')}/${dateCreation.day.toString().padLeft(2, '0')}",
                  style: Theme.of(context).textTheme.bodyMedium!,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
