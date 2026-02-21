import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/data/model/selected_song_provider.dart';
import 'package:guitar_song_improvement/themes/spacing.dart';
import 'package:provider/provider.dart';

enum SongListTypes { links, recordings }

class Listappbar extends StatelessWidget {
  final SongListTypes listType;
  const Listappbar({super.key, required this.listType});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 70,
      backgroundColor: Colors.transparent,
      floating: true,
      automaticallyImplyLeading: false,
      flexibleSpace: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.surface,
              Theme.of(context).colorScheme.surface.withAlpha(80),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: Spacing.lg),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Provider.of<SelectedSongProvider>(
                  context,
                  listen: false,
                ).currentSong.name,
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Hero(
                tag: "song-artist",
                child: Material(
                  color: Colors.transparent,
                  child: Text.rich(
                    TextSpan(
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 14,
                        color: Colors.white70,
                        fontWeight: FontWeight.w500,
                      ),
                      children: [
                        TextSpan(
                          text: Provider.of<SelectedSongProvider>(
                            context,
                            listen: false,
                          ).currentSong.artist,
                        ),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: Spacing.xs,
                              right: Spacing.xs,
                            ),
                            child: Icon(
                              Icons.circle,
                              size: 8,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        TextSpan(
                          text: (listType == SongListTypes.links)
                              ? "${Provider.of<SelectedSongProvider>(context, listen: false).links!.length} links"
                              : "${Provider.of<SelectedSongProvider>(context, listen: false).records!.length} recordings",
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
