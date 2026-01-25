import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/controller/album_controller.dart';
import 'package:guitar_song_improvement/controller/artist_controller.dart';
import 'package:guitar_song_improvement/controller/song_controller.dart';
import 'package:guitar_song_improvement/data/model/album.dart';
import 'package:guitar_song_improvement/data/model/artist.dart';
import 'package:guitar_song_improvement/data/model/song.dart';
import 'package:guitar_song_improvement/data/model/music_provider.dart';
import 'package:guitar_song_improvement/data/local/database/dao/album_dao.dart';
import 'package:guitar_song_improvement/data/local/database/dao/artist_dao.dart';
import 'package:guitar_song_improvement/data/local/database/dao/song_dao.dart';
import 'package:guitar_song_improvement/themes/spacing.dart';
import 'package:guitar_song_improvement/ui/screens/home/view_models/home_viewmodel.dart';
import 'package:guitar_song_improvement/ui/screens/home/widgets/home_section.dart';
import 'package:guitar_song_improvement/ui/screens/form/save_song/save_song_screen.dart';
import 'package:guitar_song_improvement/ui/screens/search/search_screen.dart';
import 'package:guitar_song_improvement/ui/widgets/add_new_song_button.dart';
import 'package:guitar_song_improvement/ui/widgets/search_song.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeViewmodel homeVM = HomeViewmodel(
      songController: SongController(),
      albumController: AlbumController(),
      artistController: ArtistController(),
    );

    return Consumer<MusicProvider>(
      builder: (context, data, child) {
        // data.getData(); // Initialize on splash screen when created / When changing the song list, can create a method with notifylistener instead of putting the value of database in here (because notifylisteners make the widgets that use consumer reload)

        if (data.songs == null || data.songs!.isEmpty) {
          return NoSongsHomeScreen(homeVM: homeVM);
        }

        return StandardHomeScreen(data.songs!, homeVM: homeVM);
      },
    );
  }
}

class NoSongsHomeScreen extends StatelessWidget {
  final HomeViewmodel homeVM;
  const NoSongsHomeScreen({super.key, required this.homeVM});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.settings),
          color: Colors.white,
          onPressed: () async {
            List<Song> songs = await homeVM.getAllSongs;

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
            SearchSong(
              hint: "Search a new song...",
              onSearch: (value) => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SearchScreen(search: value),
                ),
              ),
            ),
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

class StandardHomeScreen extends StatelessWidget {
  final HomeViewmodel homeVM;
  final List<Song> songs;

  const StandardHomeScreen(this.songs, {super.key, required this.homeVM});

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
            // Just testing!!! Take it off later !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
            SongDao songDao = SongDao();
            songDao.deleteAll();

            AlbumDao albumDao = AlbumDao();
            ArtistDao artistDao = ArtistDao();

            albumDao.deleteAll();
            artistDao.deleteAll();

            Provider.of<MusicProvider>(context, listen: false).getData();
            // til here
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
                printData();

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SaveSongScreen()),
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
              child: SearchSong(
                hint: "Search a song",
                onSearch: (value) => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SearchScreen(search: value),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: Spacing.xs),
              child: HomeSection("Last added", songs),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> printData() async {
    // This is a test function used to debug and see data, take it off later, i won't be useful for the app itself
    SongController songController = SongController();
    AlbumController albumcontroller = AlbumController();
    ArtistController artistController = ArtistController();

    AlbumDao albumDao = AlbumDao();
    ArtistDao artistDao = ArtistDao();
    SongDao songDao = SongDao();

    List<Song> songs = await songController.readAll();
    List<Album> albums = await albumcontroller.readAll();
    List<Artist> artists = await artistController.readAll();

    print("\n\n\n\nSONGS\n\n");
    for (int i = 0; i < songs.length; i++) {
      print(
        "Song ${i + 1} - ${songs[i].name} | ${songs[i].album} | ${songs[i].artist}",
      );
    }

    print(
      "\n\n\n\n--------------------------------------------------------------------------------\n\n",
    );
    print("ALBÚMS\n\n");
    for (int i = 0; i < albums.length; i++) {
      print(
        "Albúm ${i + 1} - ${albums[i].name} - Has songs : ${await albumDao.hasSongs(albums[i])} - Exists : ${await albumDao.exists(albums[i])}",
      );
      print("\n");

      final List<Song> songsByAlbum = await songDao.getSongsByAlbum(albums[i]);

      for (int i = 0; i < songsByAlbum.length; i++) {
        print("---- ${songsByAlbum[i].name} - ${songsByAlbum[i].artist}\n");
      }
    }

    print(
      "\n\n\n\n--------------------------------------------------------------------------------\n\n",
    );
    print("ARTISTS\n\n");
    for (int i = 0; i < artists.length; i++) {
      print(
        "Artist ${i + 1} - ${artists[i].name} - Has songs : ${await artistDao.hasSongs(artists[i])} - Exists : ${await artistDao.exists(artists[i])}",
      );
      print("\n");

      final List<Song> songsByArtist = await songDao.getSongsByArtist(
        artists[i],
      );

      for (int i = 0; i < songsByArtist.length; i++) {
        print("---- ${songsByArtist[i].name} - ${songsByArtist[i].album}\n");
      }
    }

    print("\n\n\n\n");
  }
}
