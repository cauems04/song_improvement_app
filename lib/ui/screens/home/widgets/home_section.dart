import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/data/model/song.dart';
import 'package:guitar_song_improvement/ui/widgets/song_card.dart';

class HomeSection extends StatelessWidget {
  final List<Song> songs;
  final String title;

  const HomeSection(this.title, this.songs, {super.key});

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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.headlineSmall),
        ...songCards,
      ],
    );
  }
}
