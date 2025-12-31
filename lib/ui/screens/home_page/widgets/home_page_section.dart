import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/model/song.dart';
import 'package:guitar_song_improvement/ui/components/box_form.dart';
import 'package:guitar_song_improvement/ui/components/song_card.dart';

class HomePageSection extends StatelessWidget {
  final List<Song> songs;
  final String title;

  const HomePageSection(this.title, this.songs, {super.key});

  List<SongCard> songToCard(List<Song> songs) {
    List<SongCard> songCards = [];
    for (Song song in songs) {
      songCards.add(SongCard(song));
    }

    return songCards;
  }

  @override
  Widget build(BuildContext context) {
    List<SongCard> songCards = songToCard(songs);

    return BoxForm(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.headlineSmall),
          ...songCards,
        ],
      ),
    );
  }
}
