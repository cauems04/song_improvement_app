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
  HomePage({super.key}) {
    songs = getData();
  }

  Future<List<Song>>? songs;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: songs,
      builder: (context, snapshot) {
        Widget child;

        if (snapshot.hasError) {
          child = Center(child: Text("An error has shown up, try again later"));
        }

        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            child = CircularProgressIndicator();

          case ConnectionState.active:
            child = CircularProgressIndicator();

          case ConnectionState.none:
            print("X No songs found X - None");
            child = NoSongsHomePage();

          case ConnectionState.done:
            List<Song>? songsData = snapshot.data;
            (songsData == null || songsData.isEmpty)
                ? print(
                    "X No songs found X",
                  ) // Take it off later !!!!!!!!!!!!!!!!!!!!
                : print("! All songs found !");
            child = (songsData == null || songsData.isEmpty)
                ? NoSongsHomePage()
                : StandardHomePage(songsData);
        }

        return child;
      },
    );
  }

  Future<List<Song>>? getData() async {
    SongDao songDao = SongDao();
    List<Song>? songs = await songDao.readAll();
    return songs;
  }
}

class NoSongsHomePage extends StatelessWidget {
  const NoSongsHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.settings),
          color: Colors.white,
          onPressed: () async {
            SongDao songDao = SongDao();

            List<Song> songs = await songDao.readAll();

            for (Song song in songs) {
              print("${song.name} - ${song.album} - ${song.artist}\n");
            }
          },
        ),
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
  final List<Song> songs;

  const StandardHomePage(this.songs, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        leading: InkWell(
          customBorder: CircleBorder(),
          child: Icon(Icons.settings, color: Colors.white),
          onTap: () {
            SongDao songDao = SongDao();
            songDao
                .deleteAllSongs(); // Just testing!!! Take it off later !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
          },
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
              child: HomePageSection("Last added", songs),
            ),
          ],
        ),
      ),
    );
  }
}

class HomePageSection extends StatelessWidget {
  final List<Song> songs;
  final String title;

  const HomePageSection(this.title, this.songs, {super.key});

  List<SongCard> songToCard(List<Song> songs) {
    List<SongCard> songCards = [];
    for (Song song in songs) {
      songCards.add(SongCard(song));
    }

    return songCards;
  }

  @override
  Widget build(BuildContext context) {
    List<SongCard> songCards = songToCard(songs);

    return BoxForm(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.headlineSmall),
          ...songCards,
          // SongCard("Down in a hole", "Alice in Chains", "3:20"),
          // SongCard("One", "Mettalica", "1:58"),
        ],
      ),
    );
  }
}
