import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/data/model/song.dart';
import 'package:guitar_song_improvement/themes/spacing.dart';
import 'package:guitar_song_improvement/ui/widgets/song_card.dart';

class SongSection extends StatelessWidget {
  final List<Song> songs;

  const SongSection(this.songs, {super.key});

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
        Padding(
          padding: const EdgeInsets.only(bottom: Spacing.xs),
          child: Text(
            "Songs",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: songCards.length,
          itemBuilder: (context, index) {
            return songCards[index];
          },
        ),
      ],
    );
  }
}
