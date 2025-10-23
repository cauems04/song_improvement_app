import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/controller/songController.dart';
import 'package:guitar_song_improvement/model/song.dart';
import 'package:guitar_song_improvement/model/songs_provider.dart';
import 'package:guitar_song_improvement/screens/Components/filter_option.dart';
import 'package:guitar_song_improvement/screens/Components/search_song.dart';
import 'package:guitar_song_improvement/screens/Components/song_card.dart';
import 'package:guitar_song_improvement/themes/spacing.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  final String search;
  const SearchPage({super.key, this.search = ""});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  int currentPageIndex = 0;
  Songcontroller songController = Songcontroller();
  String search = "";

  @override
  void initState() {
    super.initState();
    search = widget.search;
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
            SearchSong(
              hint: "Search a song",
              search: search,
              onSearch: (value) {
                if (value != search) {
                  setState(() {
                    search = value;
                  });
                }
              },
              onChanged: (value) {
                if (currentPageIndex == 1) {
                  setState(() {
                    search = value;
                  });
                }
              },
            ),
            Expanded(
              child: (currentPageIndex == 0)
                  ? _OnlineSearch(songController, search: search)
                  : _LocalSearch(search: search),
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

class _OnlineSearch extends StatelessWidget {
  final Songcontroller songController;
  final String search;

  const _OnlineSearch(this.songController, {this.search = ""});

  @override
  Widget build(BuildContext context) {
    final Future<List<Song>> songsFound = songController.searchSongs(search);

    return Padding(
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
      ),
    );
  }
}

class _LocalSearch extends StatefulWidget {
  final String search;

  const _LocalSearch({this.search = ""});

  @override
  State<_LocalSearch> createState() => __LocalSearchState();
}

class __LocalSearchState extends State<_LocalSearch> {
  String? currentFilter;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: Spacing.md),
      child: Column(
        children: [
          SizedBox(
            height: 50,
            child: Padding(
              padding: const EdgeInsets.only(bottom: Spacing.md),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  FilterOption(
                    label: "Albums",
                    isSelected: (currentFilter == "albums"),
                    onTap: () {
                      setState(() {
                        if (currentFilter == "albums") {
                          currentFilter = null;
                          return;
                        }

                        currentFilter = "albums";
                      });
                    },
                  ),
                  FilterOption(
                    label: "Artists",
                    isSelected: (currentFilter == "artists"),
                    onTap: () {
                      setState(() {
                        if (currentFilter == "artists") {
                          currentFilter = null;
                          return;
                        }

                        currentFilter = "artists";
                      });
                    },
                  ),
                  FilterOption(
                    label: "Favorites",
                    isSelected: (currentFilter == "favorites"),
                    onTap: () {
                      setState(() {
                        if (currentFilter == "favorites") {
                          currentFilter = null;
                          return;
                        }

                        currentFilter = "favorites";
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Consumer<SongsProvider>(
              builder: (context, songsData, child) {
                return FutureBuilder(
                  future: (widget.search.isNotEmpty)
                      ? songsData.filterSong(widget.search)
                      : songsData.songs,
                  builder: (context, snapshot) {
                    Widget child;

                    if (snapshot.hasError) {
                      return Center(
                        child: Text("An error has shown up, try again"),
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
                        List<SongCard> songWidgets = [];
                        if (snapshot.data != null) {
                          for (Song song in snapshot.data!) {
                            songWidgets.add(SongCard(song));
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
