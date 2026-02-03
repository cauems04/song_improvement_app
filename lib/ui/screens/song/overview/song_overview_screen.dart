import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/data/model/selected_song_provider.dart';
import 'package:guitar_song_improvement/themes/spacing.dart';
import 'package:guitar_song_improvement/ui/screens/song/overview/widgets/progress_graph.dart';
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
                      child: ProgressGraph(data.currentSong.reducedScore),
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
