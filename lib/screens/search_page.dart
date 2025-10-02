import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/controller/songController.dart';
import 'package:guitar_song_improvement/model/song.dart';
import 'package:guitar_song_improvement/screens/Components/search_song.dart';
import 'package:guitar_song_improvement/screens/Components/song_card.dart';
import 'package:guitar_song_improvement/themes/spacing.dart';

class SearchPage extends StatefulWidget {
  final String? search;
  const SearchPage({super.key, this.search});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  int currentPageIndex = 0;
  final Songcontroller songcontroller = Songcontroller();
  late Future<List<Song>> songsFound;

  @override
  void initState() {
    super.initState();
    songsFound = songcontroller.searchSongs(
      widget.search ?? "",
    ); // Verify when the search is empty later, to eventually treat it
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
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
            SearchSong(hint: "Search a song", search: widget.search),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: Spacing.md),
                child: FutureBuilder(
                  future: songsFound,
                  builder: (context, snapshot) {
                    Widget child;

                    if (snapshot.hasError) {
                      return Center(
                        child: Text("An error has shown up, try again later"),
                      );
                    }

                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        child = Center(child: CircularProgressIndicator());
                        break;
                      case ConnectionState.none:
                        child = Center(child: Text("No songs found"));
                        break;
                      case ConnectionState.done:
                        List<SongCardSearch> songWidgets = [];
                        if (snapshot.data != null) {
                          for (Song song in snapshot.data!) {
                            songWidgets.add(SongCardSearch(song));
                          }
                        }
                        child = ListView(children: songWidgets);
                        break;
                      default:
                        child = Center(child: Text("Resposta padrão"));
                        break;
                    }
                    return child;
                  },
                  // child: ListView(
                  //   children: [
                  //     SongCard("Nutshell", "Alice in Chains", "5:50"),
                  //     SongCard("Still remains", "Stone Temple Pilots", "4:40"),
                  //     SongCard("Down in a hole", "Alice in Chains", "3:20"),
                  //     SongCard("One", "Mettalica", "1:58"),
                  //     SongCard("Afterlife", "Avenged Sevenfold", "1:20"),
                  //     SongCard("Arabella", "Arctic Monkeys", "2:48"),
                  //     SongCard("Na sua estante", "Pitty", "2:40"),
                  //     SongCard("Hit that", "The Offspring", "3:22"),
                  //     SongCard("Hit that", "The Offspring", "3:22"),
                  //     SongCard("Hit that", "The Offspring", "3:22"),
                  //   ],
                  // ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        indicatorColor: Theme.of(context).colorScheme.onPrimary,
        onDestinationSelected: (index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.online_prediction),
            label: "Online Search",
          ),
          NavigationDestination(icon: Icon(Icons.list), label: "Saved Songs"),
        ],
        selectedIndex: currentPageIndex,
      ),
    );
  }
}
