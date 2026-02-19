import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/data/model/selected_song_provider.dart';
import 'package:guitar_song_improvement/themes/spacing.dart';
import 'package:guitar_song_improvement/ui/screens/song/overview/widgets/info_card.dart';
import 'package:guitar_song_improvement/ui/widgets/progress_graph.dart';
import 'package:provider/provider.dart';

class SongOverviewScreen extends StatelessWidget {
  const SongOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.surface,
              Theme.of(context).colorScheme.onSurface,
              Theme.of(context).colorScheme.surface,
            ],
            begin: AlignmentGeometry.topLeft,
            end: AlignmentGeometry.bottomRight,
          ),
        ),
        child: Padding(
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
                        style: Theme.of(context).textTheme.headlineLarge!
                            .copyWith(
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: Spacing.sm,
                        ),
                        child: Text.rich(
                          TextSpan(
                            children: [
                              WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: Icon(
                                  Icons.person,
                                  size: 18,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.surfaceContainerHigh,
                                ),
                              ),
                              const WidgetSpan(child: SizedBox(width: 4)),
                              TextSpan(text: data.currentSong.artist),
                            ],
                          ),
                          style: Theme.of(context).textTheme.titleLarge!
                              .copyWith(
                                fontWeight: FontWeight.w400,
                                color: Theme.of(
                                  context,
                                ).colorScheme.surfaceContainerHigh,
                              ),
                        ),
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            WidgetSpan(
                              alignment: PlaceholderAlignment.middle,
                              child: Icon(
                                Icons.library_music,
                                size: 18,
                                color: Theme.of(
                                  context,
                                ).colorScheme.surfaceContainer,
                              ),
                            ),
                            const WidgetSpan(child: SizedBox(width: 4)),
                            TextSpan(text: data.currentSong.album),
                          ],
                        ),
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).colorScheme.surfaceContainer,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: Spacing.xxl,
                          bottom: Spacing.xxxl,
                        ),
                        child: SizedBox(
                          height: 90,
                          child: ProgressGraph(data.currentSong.reducedScore),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InfoCard(
                            child: SizedBox(
                              width: 100,
                              height: 90,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    Icons.link,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onPrimary,
                                  ),
                                  Text(
                                    (Provider.of<SelectedSongProvider>(
                                              context,
                                            ).links?.length ??
                                            0)
                                        .toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge!
                                        .copyWith(fontSize: 22),
                                  ),
                                  Text(
                                    "Links",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.surfaceContainer,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InfoCard(
                            child: SizedBox(
                              width: 100,
                              height: 90,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    Icons.play_arrow_outlined,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onPrimary,
                                  ),
                                  Text(
                                    Provider.of<SelectedSongProvider>(
                                      context,
                                    ).currentSong.timesPlayed.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge!
                                        .copyWith(fontSize: 22),
                                  ),
                                  Text(
                                    "Times Played",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.surfaceContainer,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InfoCard(
                            child: SizedBox(
                              width: 100,
                              height: 90,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    Icons.mic_none_rounded,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onPrimary,
                                  ),
                                  Text(
                                    (Provider.of<SelectedSongProvider>(
                                              context,
                                            ).links?.length ??
                                            0)
                                        .toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge!
                                        .copyWith(fontSize: 22),
                                  ),
                                  Text(
                                    "Recordings",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.surfaceContainer,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
