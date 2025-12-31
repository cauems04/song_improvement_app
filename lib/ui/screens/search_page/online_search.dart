import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/controller/song_controller.dart';
import 'package:guitar_song_improvement/model/song.dart';
import 'package:guitar_song_improvement/themes/spacing.dart';
import 'package:guitar_song_improvement/ui/components/song_card.dart';

class OnlineSearch extends StatelessWidget {
  final SongController songController;
  final String search;

  const OnlineSearch(this.songController, {this.search = ""});

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
