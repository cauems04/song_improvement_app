import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/data/model/album.dart';
import 'package:guitar_song_improvement/themes/spacing.dart';
import 'package:guitar_song_improvement/ui/widgets/album_card.dart';

class AlbumSection extends StatelessWidget {
  final List<Album> albums;

  const AlbumSection(this.albums, {super.key});

  List<AlbumCard> albumToCard(List<Album> albums) {
    List<AlbumCard> albumCards = [];
    for (Album album in albums) {
      albumCards.add(AlbumCard(album));
    }

    return albumCards;
  }

  @override
  Widget build(BuildContext context) {
    List<AlbumCard> albumCards = albumToCard(albums);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: Spacing.xs),
          child: Text(
            "Albums",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        SizedBox(
          height: 165,
          child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: albumCards.length,
            separatorBuilder: (context, index) => SizedBox(width: Spacing.xs),
            itemBuilder: (context, index) {
              return albumCards[index];
            },
          ),
        ),
      ],
    );
  }
}
