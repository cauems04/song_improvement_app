import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/screens/Components/search_options.dart';
import 'package:guitar_song_improvement/screens/Components/search_song.dart';
import 'package:guitar_song_improvement/themes/spacing.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        leading: InkWell(
          customBorder: CircleBorder(),
          child: Icon(Icons.settings, color: Colors.white),
          onTap: () {},
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: Spacing.sm),
            child: InkWell(
              customBorder: CircleBorder(),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Icon(
                  Icons.dark_mode,
                  color: Theme.of(context).colorScheme.surfaceContainerHigh,
                ),
              ),
              onTap: () {},
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(
          Spacing.lg,
          Spacing.sm,
          Spacing.lg,
          Spacing.sm,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SearchSong("Search a song"),
            // Expanded(
            //   child: Padding(
            //     padding: const EdgeInsets.only(
            //       left: 20,
            //       top: 20,
            //       right: 20,
            //       bottom: 10,
            //     ),
            //     // child: ListView(
            //     //   children: [
            //     //     SongCard("Nutshell", "Alice in Chains", "5:50"),
            //     //     SongCard("Still remains", "Stone Temple Pilots", "4:40"),
            //     //     SongCard("Down in a hole", "Alice in Chains", "3:20"),
            //     //     SongCard("One", "Mettalica", "1:58"),
            //     //     SongCard("Afterlife", "Avenged Sevenfold", "1:20"),
            //     //     SongCard("Arabella", "Arctic Monkeys", "2:48"),
            //     //     SongCard("Na sua estante", "Pitty", "2:40"),
            //     //     SongCard("Hit that", "The Offspring", "3:22"),
            //     //   ],
            //     // ),
            //   ),
            // ),
          ],
        ),
      ),
      bottomNavigationBar: Placeholder(),
    );
  }
}
