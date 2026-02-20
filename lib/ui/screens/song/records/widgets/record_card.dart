import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/data/model/record.dart';
import 'package:guitar_song_improvement/data/model/selected_song_provider.dart';
import 'package:guitar_song_improvement/themes/spacing.dart';
import 'package:guitar_song_improvement/ui/screens/audio/play_audio/play_audio_screen.dart';
import 'package:guitar_song_improvement/ui/screens/song/records/widgets/progress_bar.dart';
import 'package:provider/provider.dart';

class RecordCard extends StatelessWidget {
  final Record record;
  const RecordCard(this.record, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.surfaceContainerLow,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Material(
        color: Theme.of(
          context,
        ).colorScheme.surfaceContainerLowest.withAlpha(100),
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.all(Spacing.md),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        record.name,
                        style: Theme.of(context).textTheme.headlineSmall!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Text.rich(
                            TextSpan(
                              children: [
                                WidgetSpan(
                                  child: Icon(
                                    Icons.date_range,
                                    color: Colors.white70,
                                    size: 14,
                                  ),
                                ),
                                WidgetSpan(child: SizedBox(width: 2)),
                                TextSpan(
                                  text: record.formatedDate,
                                  style: Theme.of(context).textTheme.bodyMedium!
                                      .copyWith(
                                        color: Colors.white70,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: Spacing.sm),
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  WidgetSpan(
                                    child: Icon(
                                      Icons.access_time_rounded,
                                      color: Colors.white70,
                                      size: 14,
                                    ),
                                  ),
                                  WidgetSpan(child: SizedBox(width: 2)),
                                  TextSpan(
                                    text: "3:40",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          color: Colors.white70,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  GestureDetector(
                    child: Icon(
                      Icons.more_vert,
                      size: 24,
                      color: Colors.grey[500],
                    ),
                    onTap: () => null,
                  ),
                ],
              ),
              ProgressBar(progressValue: (record.score ?? 0) * 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
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
                    child: Container(
                      height: 44,
                      width: 44,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(context).colorScheme.onPrimary,
                            Colors.purpleAccent[100]!,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.play_arrow,
                          color: Colors.white.withAlpha(180),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(6, 2, 6, 2),
                    decoration: BoxDecoration(
                      color: (record.score != null)
                          ? Theme.of(context).colorScheme.primary.withAlpha(180)
                          : Colors.grey[800]!.withAlpha(100),
                      border: Border.all(
                        color: (record.score != null)
                            ? Theme.of(context).colorScheme.onPrimary
                            : Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: (record.score != null)
                        ? Text.rich(
                            TextSpan(
                              children: [
                                WidgetSpan(
                                  child: Icon(
                                    Icons.bar_chart,
                                    color: Colors.white70,
                                    size: 14,
                                  ),
                                ),
                                WidgetSpan(child: SizedBox(width: 2)),
                                TextSpan(
                                  text: record.score.toString(),
                                  style: Theme.of(context).textTheme.bodyMedium!
                                      .copyWith(
                                        color: Colors.white70,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ],
                            ),
                          )
                        : Icon(Icons.remove, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
