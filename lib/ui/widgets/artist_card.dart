import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/data/model/artist.dart';
import 'package:guitar_song_improvement/data/model/music_provider.dart';
import 'package:guitar_song_improvement/themes/spacing.dart';
import 'package:provider/provider.dart';

class ArtistCard extends StatelessWidget {
  final Artist artist;

  const ArtistCard(this.artist, {super.key});

  String get getInitials => artist.name
      .trim()
      .split(" ")
      .where((text) => text.isNotEmpty)
      .take(2)
      .map((text) => text[0])
      .join()
      .toUpperCase();

  Color getColorFromText(String text) {
    final hash = text.hashCode;
    return Color((hash & 0xFFFFFF) | 0xFF000000);
  }

  @override
  Widget build(BuildContext context) {
    final Color baseColor = getColorFromText(artist.name);

    return SizedBox(
      height: 60,
      width: 50,
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          customBorder: Border.all(
            color: Theme.of(context).colorScheme.surfaceContainerLow,
            width: 5,
          ),
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => SongPage(song)),
            // );
          },
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black.withAlpha(40), baseColor.withAlpha(60)],
              ),
              border: Border.all(color: baseColor.withAlpha(80)),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: -20,
                  right: -20,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: baseColor.withAlpha(60),
                    child: Text(
                      getInitials,
                      style: Theme.of(context).textTheme.headlineLarge!
                          .copyWith(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white.withAlpha(60),
                          ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: Spacing.xs,
                      left: Spacing.xs,
                    ),
                    child: Icon(
                      Icons.person,
                      color: Theme.of(
                        context,
                      ).colorScheme.onPrimary.withAlpha(140),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsGeometry.fromLTRB(
                    Spacing.md,
                    Spacing.none,
                    Spacing.xs,
                    Spacing.xl,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        artist.name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "${Provider.of<MusicProvider>(context).songsByArtistCount(artist.name)} Songs",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.white.withAlpha(160),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
