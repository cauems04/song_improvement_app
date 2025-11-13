import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/model/selected_song_provider.dart';
import 'package:guitar_song_improvement/model/song.dart';
import 'package:provider/provider.dart';

class SongOverviewPage extends StatelessWidget {
  const SongOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, right: 20, left: 20),
      child: SingleChildScrollView(
        child: Center(
          child: Consumer<SelectedSongProvider>(
            builder: (context, data, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    data.currentSong.name,
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: Text(
                      data.currentSong.artist,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  Text(
                    data.currentSong.album,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 200,
                    ), // TESTESTESTESTESTESTESTESTESTE
                    child: SizedBox(),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
