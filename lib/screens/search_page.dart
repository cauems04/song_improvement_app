import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/screens/Components/search_options.dart';
import 'package:guitar_song_improvement/screens/Components/search_song.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

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
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: InkWell(
              customBorder: CircleBorder(),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Icon(Icons.dark_mode, color: Colors.white),
              ),
              onTap: () {},
            ),
          ),
        ],
        backgroundColor: Color.fromRGBO(47, 48, 54, 1),
      ),
      body: Center(
        child: Column(
          children: [
            SearchSong("Search a song"),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 12),
              child: SearchOptions(),
            ),
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
    );
  }
}
