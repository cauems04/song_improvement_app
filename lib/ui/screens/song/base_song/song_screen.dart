import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/controller/album_controller.dart';
import 'package:guitar_song_improvement/controller/artist_controller.dart';
import 'package:guitar_song_improvement/controller/song_controller.dart';
import 'package:guitar_song_improvement/data/model/music_provider.dart';
import 'package:guitar_song_improvement/data/model/selected_song_provider.dart';
import 'package:guitar_song_improvement/data/model/song.dart';
import 'package:guitar_song_improvement/themes/spacing.dart';
import 'package:guitar_song_improvement/ui/screens/form/save_link/save_link_screen.dart';
import 'package:guitar_song_improvement/ui/screens/form/save_song/save_song_screen.dart';
import 'package:guitar_song_improvement/ui/screens/song/base_song/view_models/song_screen_viewmodel.dart';
import 'package:guitar_song_improvement/ui/screens/song/base_song/widgets/top_navigation_bar.dart';
import 'package:guitar_song_improvement/ui/screens/song/links/song_links_screen.dart';
import 'package:guitar_song_improvement/ui/screens/song/overview/song_overview_screen.dart';
import 'package:provider/provider.dart';

class SongScreen extends StatefulWidget {
  const SongScreen({super.key});

  @override
  State<SongScreen> createState() => _SongScreenState();
}

class _SongScreenState extends State<SongScreen> {
  late final SongViewmodel songVM;

  @override
  void initState() {
    super.initState();
    Provider.of<SelectedSongProvider>(context, listen: false).setup();
    songVM = SongViewmodel(
      SongController(),
      AlbumController(),
      ArtistController(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: songVM.currentPage,
      builder: (context, value, child) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          floatingActionButton: (songVM.currentPage.value != 1)
              ? FloatingActionButton(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  onPressed: () {
                    switch (songVM.currentPage.value) {
                      case 0:
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (newContext) =>
                                ChangeNotifierProvider.value(
                                  value: Provider.of<SelectedSongProvider>(
                                    context,
                                  ),
                                  child: SaveLinkScreen(),
                                ),
                          ),
                        );

                        break;
                      case 1:
                        Navigator.push(
                          context, // Implement for recording audio!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! instead of saving link
                          MaterialPageRoute(
                            builder: (context) => SaveLinkScreen(),
                          ),
                        );
                        break;
                    }
                    return;
                  },
                  child: Icon(Icons.add_link),
                )
              : null,
          appBar: AppBar(
            leading: InkWell(
              customBorder: CircleBorder(),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Icon(Icons.close),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            actions: [
              if (songVM.currentPage.value == 1)
                InkWell(
                  customBorder: CircleBorder(),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Icon(Icons.edit, color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (newContext) => ChangeNotifierProvider.value(
                          value: context.read<SelectedSongProvider>(),
                          child: SaveSongScreen(
                            song: Provider.of<SelectedSongProvider>(
                              context,
                            ).currentSong,
                            isEditing: true,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              if (songVM.currentPage.value == 1)
                InkWell(
                  customBorder: CircleBorder(),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Icon(Icons.delete, color: Colors.redAccent),
                  ),
                  onTap: () async {
                    Song song = Provider.of<SelectedSongProvider>(
                      context,
                      listen: false,
                    ).currentSong;

                    songVM.deleteCurrentSong(song);

                    if (context.mounted) {
                      Provider.of<MusicProvider>(
                        context,
                        listen: false,
                      ).getData();

                      Navigator.of(context).pop();
                    }
                  },
                ),
            ],
            backgroundColor: Theme.of(context).colorScheme.surface,
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  Spacing.sm,
                  Spacing.sm,
                  Spacing.sm,
                  Spacing.none,
                ),
                child: TopNavigationBar(songVM.currentPage.value, (page) {
                  songVM.currentPage.value = page;
                }),
              ),
              if (songVM.currentPage.value == 0) SongLinksScreen(),
              if (songVM.currentPage.value == 1) SongOverviewScreen(),
            ],
          ),
        );
      },
    );
  }
}

// class LinksPage extends StatefulWidget {
//   const LinksPage({super.key});

//   @override
//   State<LinksPage> createState() => _LinksPageState();
// }

// class _LinksPageState extends State<LinksPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }

// class CustomTextFormField extends StatelessWidget {
//   final String fieldName;
//   const CustomTextFormField(this.fieldName, {super.key});

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       style: TextStyle(color: Colors.white),
//       decoration: InputDecoration(
//         labelText: fieldName,
//         labelStyle: TextStyle(color: Colors.white60, fontSize: 16),
//       ),
//     );
//   }
// }

// class _LinkSection extends StatefulWidget {
//   const _LinkSection();

//   @override
//   State<_LinkSection> createState() => _linkSectionState();
// }

// class _linkSectionState extends State<_LinkSection> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text("Support Links", style: Theme.of(context).textTheme.titleLarge),
//         Padding(
//           padding: const EdgeInsets.only(top: Spacing.xs, bottom: Spacing.xs),
//           child: Container(width: 300, height: 2, color: Colors.white),
//         ),
//         Text(
//           "www.youtube.com/2rdchfidsbds78dh8i",
//           style: Theme.of(context).textTheme.bodyLarge,
//         ),
//         Icon(Icons.add),
//       ],
//     );
//   }
// }
