import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/controller/album_controller.dart';
import 'package:guitar_song_improvement/controller/artist_controller.dart';
import 'package:guitar_song_improvement/controller/song_controller.dart';
import 'package:guitar_song_improvement/data/model/album.dart';
import 'package:guitar_song_improvement/data/model/artist.dart';
import 'package:guitar_song_improvement/data/model/music_provider.dart';
import 'package:guitar_song_improvement/data/model/selected_song_provider.dart';
import 'package:guitar_song_improvement/data/model/song.dart';
import 'package:guitar_song_improvement/themes/spacing.dart';
import 'package:guitar_song_improvement/ui/screens/form/save_link/save_link_screen.dart';
import 'package:guitar_song_improvement/ui/screens/form/save_song/save_song_screen.dart';
import 'package:guitar_song_improvement/ui/screens/song/links/song_links_screen.dart';
import 'package:guitar_song_improvement/ui/screens/song/overview/song_overview_screen.dart';
import 'package:provider/provider.dart';

class SongScreen extends StatefulWidget {
  const SongScreen({super.key});

  @override
  State<SongScreen> createState() => _SongScreenState();
}

class _SongScreenState extends State<SongScreen> {
  int currentPage = 1;

  @override
  void initState() {
    Provider.of<SelectedSongProvider>(context, listen: false).setup();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      floatingActionButton: (currentPage != 1)
          ? FloatingActionButton(
              backgroundColor: Theme.of(context).colorScheme.primary,
              onPressed: () {
                switch (currentPage) {
                  case 0:
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (newContext) => ChangeNotifierProvider.value(
                          value: Provider.of<SelectedSongProvider>(context),
                          child: SaveLinkScreen(),
                        ),
                      ),
                    );

                    break;
                  case 1:
                    Navigator.push(
                      context, // Implement for recording audio!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! instead of saving link
                      MaterialPageRoute(builder: (context) => SaveLinkScreen()),
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
          if (currentPage == 1)
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
                    builder: (context) => SaveSongScreen(
                      song: Provider.of<SelectedSongProvider>(
                        context,
                      ).currentSong,
                      isEditing: true,
                    ),
                  ),
                );
              },
            ),
          if (currentPage == 1)
            InkWell(
              customBorder: CircleBorder(),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Icon(Icons.delete, color: Colors.redAccent),
              ),
              onTap: () async {
                SongController songController = SongController();
                AlbumController albumController = AlbumController();
                ArtistController artistController = ArtistController();

                Song song = Provider.of<SelectedSongProvider>(
                  context,
                  listen: false,
                ).currentSong;

                await songController.delete(song);
                await albumController.delete(Album(name: song.album));
                await artistController.delete(Artist(name: song.artist));

                if (context.mounted) {
                  Provider.of<MusicProvider>(context, listen: false).getData();

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
            child: TopNavigationBar(currentPage, (page) {
              if (page != currentPage) {
                setState(() {
                  currentPage = page;
                });
              }
            }),
          ),
          if (currentPage == 0) SongLinksScreen(),
          if (currentPage == 1) SongOverviewScreen(),
        ],
      ),
    );
  }
}

class TopNavigationBar extends StatelessWidget {
  final int currentPage;

  final Function(int) onTap;

  const TopNavigationBar(this.currentPage, this.onTap, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _NavElement(0, "Links", currentPage: currentPage, onTap: onTap),
        _NavElement(1, "Overview", currentPage: currentPage, onTap: onTap),
        _NavElement(2, "Records", currentPage: currentPage, onTap: onTap),
      ],
    );
  }
}

class _NavElement extends StatelessWidget {
  final int pageNumber;
  final String label;
  final int currentPage;
  final Function(int) onTap;

  const _NavElement(
    this.pageNumber,
    this.label, {
    required this.currentPage,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(pageNumber),
      child: Padding(
        padding: const EdgeInsets.all(Spacing.xs),
        child: Column(
          children: [
            Text(
              label,
              style: (currentPage == pageNumber)
                  ? Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                    )
                  : Theme.of(context).textTheme.titleLarge,
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              height: 3,
              width: (currentPage == pageNumber) ? 20 : 0,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onPrimary,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LinksPage extends StatefulWidget {
  const LinksPage({super.key});

  @override
  State<LinksPage> createState() => _LinksPageState();
}

class _LinksPageState extends State<LinksPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

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
