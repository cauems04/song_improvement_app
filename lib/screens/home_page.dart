import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/model/song.dart';
import 'package:guitar_song_improvement/repository/dal/song_dao.dart';
import 'package:guitar_song_improvement/screens/Components/BoxForm.dart';
import 'package:guitar_song_improvement/screens/Components/add_new_song_button.dart';
import 'package:guitar_song_improvement/screens/Components/search_song.dart';
import 'package:guitar_song_improvement/screens/Components/song_card.dart';
import 'package:guitar_song_improvement/screens/save_song_page.dart';
import 'package:guitar_song_improvement/themes/spacing.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return StandardHomePage();
  }
}

class NoSongsHomePage extends StatelessWidget {
  const NoSongsHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        leading: Icon(Icons.settings, color: Colors.white),
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: Spacing.xl, right: Spacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SearchSong(hint: "Search a new song..."),
            Padding(
              padding: EdgeInsets.only(top: Spacing.xl, bottom: Spacing.xl),
              child: Text(
                "Or",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            AddNewSongButton(),
          ],
        ),
      ),
    );
  }
}

class StandardHomePage extends StatelessWidget {
  const StandardHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        leading: InkWell(
          customBorder: CircleBorder(),
          child: Icon(Icons.settings, color: Colors.white),
          onTap: () {},
        ),
        actions: [
          InkWell(
            customBorder: CircleBorder(),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Icon(Icons.dark_mode, color: Colors.white),
            ),
            onTap: () {},
          ),
          Padding(
            padding: const EdgeInsets.only(left: Spacing.xs, right: Spacing.sm),
            child: InkWell(
              customBorder: CircleBorder(),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Icon(
                  Icons.add_box,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              onTap: () async {
                List<Song> songs = await SongDao().readAll();
                print("------------------------------");
                print(songs[1].name + songs[1].artist + songs[1].album);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SaveSongPage()),
                );
              },
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
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: Spacing.sm),
              child: SearchSong(hint: "Search a song"),
            ),
            Padding(
              padding: const EdgeInsets.only(top: Spacing.xs),
              child: BoxForm(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Last added",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    SongCard(
                      Song(
                        name: "Nutshell",
                        artist: "Alice in Chains",
                        album: "5:50",
                      ),
                    ),
                    SongCard(
                      Song(
                        name: "Still remains",
                        artist: "Stone Temple Pilots",
                        album: "4:40",
                      ),
                    ),
                    // SongCard("Down in a hole", "Alice in Chains", "3:20"),
                    // SongCard("One", "Mettalica", "1:58"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
