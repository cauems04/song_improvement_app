import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/screens/Components/add_new_song_button.dart';
import 'package:guitar_song_improvement/screens/Components/search_song.dart';
import 'package:guitar_song_improvement/screens/Components/song_card.dart';
import 'package:guitar_song_improvement/screens/save_song_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SongFoundHomePage();
  }
}

class NoSongsHomePage extends StatelessWidget {
  const NoSongsHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(47, 48, 54, 1),
      appBar: AppBar(
        leading: Icon(Icons.settings, color: Colors.white),
        backgroundColor: Color.fromRGBO(47, 48, 54, 1),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: SearchSong("Search a new song..."),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text(
                "Or",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            AddNewSongButton(),
          ],
        ),
      ),
    );
  }
}

class SongFoundHomePage extends StatelessWidget {
  const SongFoundHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(47, 48, 54, 1),
      appBar: AppBar(
        leading: InkWell(
          customBorder: CircleBorder(),
          child: Icon(Icons.settings, color: Colors.white),
          onTap: () {},
        ),
        actions: [
          InkWell(
            customBorder: CircleBorder(),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Icon(Icons.dark_mode, color: Colors.white),
            ),
            onTap: () {},
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 12),
            child: InkWell(
              customBorder: CircleBorder(),
              child: const Padding(
                padding: EdgeInsets.all(8),
                child: Icon(
                  Icons.add_box,
                  color: Color.fromRGBO(206, 160, 221, 1),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SaveSongPage()),
                );
              },
            ),
          ),
        ],
        backgroundColor: Color.fromRGBO(47, 48, 54, 1),
      ),
      body: Center(
        child: Column(
          children: [
            SearchSong("Search a song"),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  top: 20,
                  right: 20,
                  bottom: 10,
                ),
                child: ListView(
                  children: [
                    SongCard("Nutshell", "Alice in Chains", "5:50"),
                    SongCard("Still remains", "Stone Temple Pilots", "4:40"),
                    SongCard("Down in a hole", "Alice in Chains", "3:20"),
                    SongCard("One", "Mettalica", "1:58"),
                    SongCard("Afterlife", "Avenged Sevenfold", "1:20"),
                    SongCard("Arabella", "Arctic Monkeys", "2:48"),
                    SongCard("Na sua estante", "Pitty", "2:40"),
                    SongCard("Hit that", "The Offspring", "3:22"),
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
