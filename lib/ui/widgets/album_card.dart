import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/data/model/album.dart';
import 'package:guitar_song_improvement/data/model/music_provider.dart';
import 'package:guitar_song_improvement/themes/spacing.dart';
import 'package:guitar_song_improvement/ui/screens/collection_displayer/album/album_screen.dart';
import 'package:provider/provider.dart';

class AlbumCard extends StatelessWidget {
  final Album album;

  const AlbumCard(this.album, {super.key});

  String get getInitials => album.name
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
    final Color baseColor = getColorFromText(album.name);
    final int songCount = Provider.of<MusicProvider>(
      context,
    ).songsByAlbumCount(album.name);

    return SizedBox(
      height: 60,
      width: 50,
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AlbumScreen(
                  album: album,
                  songCount: songCount,
                  baseColor: baseColor,
                ),
              ),
            );
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
                      Icons.library_music,
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
                        album.name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "$songCount Songs",
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
