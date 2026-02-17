import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/data/model/record.dart';
import 'package:guitar_song_improvement/data/model/selected_song_provider.dart';
import 'package:guitar_song_improvement/themes/spacing.dart';
import 'package:guitar_song_improvement/ui/screens/audio/play_audio/play_audio_screen.dart';
import 'package:guitar_song_improvement/ui/widgets/box_form.dart';
import 'package:provider/provider.dart';

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
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (newContext) => ChangeNotifierProvider.value(
                  value: Provider.of<SelectedSongProvider>(
                    context,
                    listen: false,
                  ),
                  child: PlayAudioScreen(
                    audioFilePath: record.audioPath,
                    isAudioSaved: true,
                  ),
                ),
              ),
            ),
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
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(record.dateCreation),
                    ],
                  ),
                  (record.score != null)
                      ? Padding(
                          padding: EdgeInsetsGeometry.only(right: Spacing.sm),
                          child: Text(
                            "${record.score}%",
                            style: Theme.of(context).textTheme.labelLarge!
                                .copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                          ),
                        )
                      : Padding(
                          padding: EdgeInsetsGeometry.only(right: Spacing.xs),
                          child: Icon(
                            Icons.bar_chart_rounded,
                            size: 40,
                            color: Colors.grey[700],
                          ),
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
