import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/controller/song_controller.dart';
import 'package:guitar_song_improvement/data/model/artist.dart';
import 'package:guitar_song_improvement/themes/spacing.dart';
import 'package:guitar_song_improvement/ui/screens/collection_displayer/album/widgets/song_section.dart';
import 'package:guitar_song_improvement/ui/screens/collection_displayer/artist/view_models/artist_viewmodel.dart';
import 'package:guitar_song_improvement/ui/screens/collection_displayer/artist/widgets/album_section.dart';

class ArtistScreen extends StatelessWidget {
  final Artist artist;
  final int songCount;
  final Color baseColor;

  ArtistScreen({
    super.key,
    required this.artist,
    required this.songCount,
    required this.baseColor,
  });

  final ArtistViewmodel artistVM = ArtistViewmodel(SongController());

  @override
  Widget build(BuildContext context) {
    artistVM.initValues(artist);

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            baseColor.withAlpha(120),
            Theme.of(context).colorScheme.surface.withAlpha(120),
          ],
          begin: AlignmentGeometry.topCenter,
          end: AlignmentGeometry.bottomCenter,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -30,
            right: -50,
            child: CircleAvatar(
              radius: 100,
              backgroundColor: baseColor.withAlpha(20),
              child: Text(
                artistVM.getInitials,
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  color: Colors.white.withAlpha(60),
                ),
              ),
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              surfaceTintColor: Colors.transparent,
              leading: InkWell(
                customBorder: CircleBorder(),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Icon(Icons.arrow_back, color: Colors.white54),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              title: Text(
                "Artist",
                style: Theme.of(
                  context,
                ).textTheme.headlineLarge!.copyWith(fontSize: 18),
              ),
              titleSpacing: 0,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  Spacing.lg,
                  Spacing.sm,
                  Spacing.lg,
                  Spacing.sm,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 90,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: Spacing.xs),
                            child: Text(
                              artist.name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: Theme.of(context).textTheme.headlineLarge!
                                  .copyWith(fontWeight: FontWeight.w600),
                            ),
                          ),
                          Text(
                            "$songCount Songs",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: Theme.of(context).textTheme.bodyLarge!
                                .copyWith(
                                  color: Colors.white.withAlpha(160),
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ],
                      ),
                    ),
                    FutureBuilder(
                      future: artistVM.getData(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }

                        if (snapshot.hasError) {
                          return Text("Erro: ${snapshot.error}");
                        }

                        return Padding(
                          padding: const EdgeInsets.only(top: Spacing.lg),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  bottom: Spacing.xl,
                                ),
                                child: AlbumSection(snapshot.data!.album),
                              ),
                              SongSection(snapshot.data!.songs),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
