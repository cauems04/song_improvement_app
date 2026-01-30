import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/data/model/selected_song_provider.dart';
import 'package:guitar_song_improvement/data/model/song.dart';
import 'package:guitar_song_improvement/ui/screens/form/save_song/save_song_screen.dart';
import 'package:guitar_song_improvement/ui/screens/song/base_song/song_screen.dart';
import 'package:guitar_song_improvement/themes/spacing.dart';
import 'package:provider/provider.dart';

class SongCard extends StatelessWidget {
  final Song song;

  const SongCard(this.song, {super.key});

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
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChangeNotifierProvider(
                  create: (context) => SelectedSongProvider(song),
                  child: SongScreen(),
                ),
              ),
            );
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 150,
                          child: Text(
                            song.name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: Theme.of(context).textTheme.bodyLarge!
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                        ),
                        Text(
                          song.artist,
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

class SongCardSearch extends StatelessWidget {
  final Song song;

  const SongCardSearch(this.song, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
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
                Image.network(
                  song.image ?? "",
                  height: 40,
                  width: 40,
                  fit: BoxFit.fill,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      "assets/images/songPlaceholderImage.png",
                    );
                  },
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: Spacing.xs),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 150,
                          child: Text(
                            song.name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: Theme.of(context).textTheme.bodyLarge!
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                        ),
                        Text(
                          song.artist,
                          textAlign: TextAlign.start,
                          style: Theme.of(context).textTheme.bodyLarge!
                              .copyWith(fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                  ),
                ),
                Material(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(10),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    splashColor: Theme.of(context).colorScheme.onPrimary,
                    child: SizedBox(
                      height: 30,
                      width: 45,
                      child: Center(
                        child: Text(
                          "Add",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SaveSongScreen(song: song),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
