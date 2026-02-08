import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/data/model/record.dart';
import 'package:guitar_song_improvement/themes/spacing.dart';
import 'package:guitar_song_improvement/ui/widgets/box_form.dart';

class RecordCard extends StatelessWidget {
  final Record record;
  const RecordCard(this.record, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Padding(
        padding: const EdgeInsetsGeometry.fromLTRB(
          Spacing.md,
          Spacing.xs,
          Spacing.xs,
          Spacing.xs,
        ),
        child: Material(
          child: InkWell(
            child: BoxForm(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        record.name,
                        style: Theme.of(context).textTheme.headlineSmall!
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      Text(record.dateCreation),
                    ],
                  ),
                  (record.score != null)
                      ? Padding(
                          padding: EdgeInsetsGeometry.only(right: Spacing.xs),
                          child: Text(
                            "${record.score}%",
                            style: Theme.of(context).textTheme.labelLarge!
                                .copyWith(color: Colors.green),
                          ),
                        )
                      : Icon(
                          Icons.bar_chart_rounded,
                          size: 40,
                          color: Colors.grey[700],
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
