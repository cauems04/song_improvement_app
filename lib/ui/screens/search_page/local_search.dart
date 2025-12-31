import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/model/album.dart';
import 'package:guitar_song_improvement/model/artist.dart';
import 'package:guitar_song_improvement/model/music_provider.dart';
import 'package:guitar_song_improvement/model/song.dart';
import 'package:guitar_song_improvement/services/filter_service.dart';
import 'package:guitar_song_improvement/themes/spacing.dart';
import 'package:guitar_song_improvement/ui/components/album_card.dart';
import 'package:guitar_song_improvement/ui/components/artist_card.dart';
import 'package:guitar_song_improvement/ui/components/filter_option.dart';
import 'package:guitar_song_improvement/ui/components/song_card.dart';
import 'package:provider/provider.dart';

class LocalSearch extends StatefulWidget {
  final String search;

  const LocalSearch({this.search = ""});

  @override
  State<LocalSearch> createState() => _LocalSearchState();
}

class _LocalSearchState extends State<LocalSearch> {
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
            child: Consumer<MusicProvider>(
              builder: (context, data, child) {
                if (!data.isLoaded) {
                  return const Center(child: CircularProgressIndicator());
                }

                Widget resultWidget = const Center(
                  child: CircularProgressIndicator(),
                );

                switch (currentFilter) {
                  case "albums":
                    if (data.albums == null || data.albums!.isEmpty) {
                      resultWidget = Center(child: Text("No albums found"));
                    }

                    List<Album> albums = (widget.search.isEmpty)
                        ? data.albums!
                        : FilterService.filter<Album>(
                            data.albums!,
                            widget.search,
                          );

                    List<AlbumCard> albumCards = albums
                        .map((album) => AlbumCard(album))
                        .toList();
                    resultWidget = ListView(children: albumCards);
                    break;

                  case "artists":
                    if (data.artists == null || data.artists!.isEmpty) {
                      resultWidget = Center(child: Text("No artists found"));
                    }

                    List<Artist> artists = (widget.search.isEmpty)
                        ? data.artists!
                        : FilterService.filter<Artist>(
                            data.artists!,
                            widget.search,
                          );

                    List<ArtistCard> artistCards = artists
                        .map((artist) => ArtistCard(artist))
                        .toList();
                    resultWidget = ListView(children: artistCards);
                    break;

                  // case "favorites":    ***REMEMBER*** Favorites will work together with the others, so its implementation's gonna be kinda different
                  //   break;

                  default:
                    if (data.songs == null || data.songs!.isEmpty) {
                      resultWidget = Center(child: Text("No songs found"));
                    }

                    List<Song> songs = (widget.search.isEmpty)
                        ? data.songs!
                        : FilterService.filter<Song>(
                            data.songs!,
                            widget.search,
                          );

                    List<SongCard> songCards = songs
                        .map((song) => SongCard(song))
                        .toList();
                    resultWidget = ListView(
                      shrinkWrap: true,
                      children: songCards,
                    );
                    break;
                }

                return resultWidget;
                // return FutureBuilder(
                //   future: (widget.search.isNotEmpty)
                //       ? songsData.filterSong(widget.search)
                //       : songsData.songs,
                //   builder: (context, snapshot) {
                //     Widget child;

                //     if (snapshot.hasError) {
                //       return Center(
                //         child: Text("An error has shown up, try again"),
                //       );
                //     }

                //     switch (snapshot.connectionState) {
                //       case ConnectionState.waiting:
                //         child = Center(child: CircularProgressIndicator());
                //         break;
                //       case ConnectionState.none:
                //         child = Center(child: Text("No songs found"));
                //         break;
                //       case ConnectionState.done:
                //         List<SongCard> songWidgets = [];
                //         if (snapshot.data != null) {
                //           for (Song song in snapshot.data!) {
                //             songWidgets.add(SongCard(song));
                //           }
                //         }
                //         child = ListView(children: songWidgets);
                //         break;
                //       default:
                //         child = Center(child: Text("Resposta padrão"));
                //         break;
                //     }
                //     return child;
                //   },
                // );
              },
            ),
          ),
        ],
      ),
    );
  }
}
