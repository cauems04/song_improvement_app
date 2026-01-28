import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/controller/song_controller.dart';
import 'package:guitar_song_improvement/themes/spacing.dart';
import 'package:guitar_song_improvement/ui/screens/search/base_searh/view_models/search_screen_viewmodel.dart';
import 'package:guitar_song_improvement/ui/screens/search/local_search/local_search_screen.dart';
import 'package:guitar_song_improvement/ui/screens/search/online_search/online_search_screen.dart';
import 'package:guitar_song_improvement/ui/widgets/search_song.dart';

class SearchScreen extends StatefulWidget {
  final String search;
  const SearchScreen({super.key, this.search = ""});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final SearchViewmodel searchVM;

  @override
  void initState() {
    super.initState();
    searchVM = SearchViewmodel(SongController());
    searchVM.intitValues(widget.search);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: searchVM,
      builder: (context, widget) {
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
                  search: searchVM.search,
                  onSearch: (value) {
                    searchVM.setSearch = value;
                  },
                  onChanged: (value) {
                    searchVM.setLocalSearch = value;
                  },
                ),
                Expanded(
                  child: (searchVM.currentPage == SearchOptions.onlineSearch)
                      ? OnlineSearchScreen(
                          searchVM.songController,
                          search: searchVM.search,
                        )
                      : LocalSearchScreen(search: searchVM.search),
                ),
              ],
            ),
          ),
          bottomNavigationBar: NavigationBar(
            backgroundColor: Theme.of(context).colorScheme.surface,
            indicatorColor: Theme.of(context).colorScheme.onPrimary,
            onDestinationSelected: (index) {
              searchVM.setCurrentPage = index;
            },
            destinations: [
              NavigationDestination(
                icon: Icon(Icons.online_prediction),
                label: "Online Search",
              ),
              NavigationDestination(
                icon: Icon(Icons.list),
                label: "Saved Songs",
              ),
            ],
            selectedIndex: searchVM.currentPage.index,
          ),
        );
      },
    );
  }
}
