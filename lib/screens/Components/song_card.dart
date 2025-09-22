import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/themes/spacing.dart';

class SongCard extends StatelessWidget {
  final String title;
  final String artist;
  final String time;

  const SongCard(this.title, this.artist, this.time, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {},
          child: Padding(
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: Theme.of(context).textTheme.bodyLarge!
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                        Text(
                          artist,
                          textAlign: TextAlign.start,
                          style: Theme.of(context).textTheme.bodyLarge!
                              .copyWith(fontWeight: FontWeight.w300),
                        ),
                      ],
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
