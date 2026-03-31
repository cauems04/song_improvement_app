import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/data/model/album.dart';
import 'package:guitar_song_improvement/data/model/artist.dart';
import 'package:guitar_song_improvement/data/model/music_provider.dart';
import 'package:guitar_song_improvement/data/model/song.dart';
import 'package:guitar_song_improvement/ui/screens/search/local_search/utils/filter_service.dart';
import 'package:guitar_song_improvement/themes/spacing.dart';
import 'package:guitar_song_improvement/ui/screens/search/local_search/view_models/local_search_viewmodel.dart';
import 'package:guitar_song_improvement/ui/widgets/album_card.dart';
import 'package:guitar_song_improvement/ui/widgets/artist_card.dart';
import 'package:guitar_song_improvement/ui/widgets/filter_option.dart';
import 'package:guitar_song_improvement/ui/widgets/song_card.dart';
import 'package:provider/provider.dart';

class LocalSearchScreen extends StatefulWidget {
  final String search;

  const LocalSearchScreen({super.key, this.search = ""});

  @override
  State<LocalSearchScreen> createState() => _LocalSearchScreenState();
}

class _LocalSearchScreenState extends State<LocalSearchScreen> {
  late final LocalSearchViewmodel localSearchVM;

  @override
  void initState() {
    super.initState();
    localSearchVM = LocalSearchViewmodel();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: Spacing.md),
      child: ValueListenableBuilder(
        valueListenable: localSearchVM.currentFilter,
        builder: (context, value, child) {
          return Column(
            children: [
              SizedBox(
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: Spacing.md),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      FilterOption(
                        label: "Songs",
                        isSelected:
                            (localSearchVM.currentFilter.value ==
                            FilterOptions.songs),
                        onTap: () {
                          localSearchVM.changeFilter(FilterOptions.songs);
                        },
                      ),
                      FilterOption(
                        label: "Albums",
                        isSelected:
                            (localSearchVM.currentFilter.value ==
                            FilterOptions.albums),
                        onTap: () {
                          localSearchVM.changeFilter(FilterOptions.albums);
                        },
                      ),
                      FilterOption(
                        label: "Artists",
                        isSelected:
                            (localSearchVM.currentFilter.value ==
                            FilterOptions.artists),
                        onTap: () {
                          localSearchVM.changeFilter(FilterOptions.artists);
                        },
                      ),
                      FilterOption(
                        label: "Favorites",
                        isSelected:
                            (localSearchVM.currentFilter.value ==
                            FilterOptions.favorites),
                        onTap: () {
                          localSearchVM.changeFilter(FilterOptions.favorites);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Consumer<MusicProvider>(
                  builder: (context, data, child) {
                    Widget resultWidget = const Center(
                      child: CircularProgressIndicator(),
                    );

                    if (!data.isLoaded) {
                      return resultWidget;
                    }

                    switch (localSearchVM.currentFilter.value) {
                      case FilterOptions.songs:
                        if (data.songs == null || data.songs!.isEmpty) {
                          resultWidget = Center(child: Text("No songs found"));
                          break;
                        }

                        List<Song> songs = (widget.search.isEmpty)
                            ? data.songs!
                            : SearchFilterUtils.filter<Song>(
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

                      case FilterOptions.albums:
                        if (data.albums == null || data.albums!.isEmpty) {
                          resultWidget = Center(child: Text("No albums found"));
                          break;
                        }

                        List<Album> albums = (widget.search.isEmpty)
                            ? data.albums!
                            : SearchFilterUtils.filter<Album>(
                                data.albums!,
                                widget.search,
                              );

                        List<AlbumCard> albumCards = albums
                            .map((album) => AlbumCard(album))
                            .toList();

                        resultWidget = GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: Spacing.lg,
                                crossAxisSpacing: Spacing.md,
                                childAspectRatio: 50 / 60,
                              ),
                          itemCount: albumCards.length,
                          itemBuilder: (context, index) => albumCards[index],
                        );
                        break;

                      case FilterOptions.artists:
                        if (data.artists == null || data.artists!.isEmpty) {
                          resultWidget = Center(
                            child: Text("No artists found"),
                          );
                          break;
                        }

                        List<Artist> artists = (widget.search.isEmpty)
                            ? data.artists!
                            : SearchFilterUtils.filter<Artist>(
                                data.artists!,
                                widget.search,
                              );

                        List<ArtistCard> artistCards = artists
                            .map((artist) => ArtistCard(artist))
                            .toList();

                        resultWidget = GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: Spacing.lg,
                                crossAxisSpacing: Spacing.md,
                                childAspectRatio: 50 / 60,
                              ),
                          itemCount: artistCards.length,
                          itemBuilder: (context, index) => artistCards[index],
                        );
                        break;

                      // case "favorites":    ***REMEMBER*** Favorites will work together with the others, so its implementation's gonna be kinda different
                      //   break;

                      default:
                    }

                    return resultWidget;
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
