import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/model/artist.dart';
import 'package:guitar_song_improvement/themes/spacing.dart';

class ArtistCard extends StatelessWidget {
  final Artist artist;

  const ArtistCard(this.artist, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => SongPage(song)),
            // );
          },
          child: Padding(
            // Take off this padding logic from here and aply inside the BoxForm
            // (Because it works well in the HomePage Sections, but not while
            // searching songs)
            padding: EdgeInsetsGeometry.fromLTRB(
              Spacing.md,
              Spacing.xs,
              Spacing.xs,
              Spacing.xs,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 150,
                      child: Text(
                        artist.name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        InkWell(
                          customBorder: CircleBorder(),
                          child: Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                          ),
                          onTap: () {},
                        ),
                        InkWell(
                          customBorder: CircleBorder(),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Icon(Icons.more_vert, color: Colors.white),
                          ),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
