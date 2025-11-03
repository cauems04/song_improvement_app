import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/model/song.dart';

class SongOverviewPage extends StatelessWidget {
  final Song song;
  const SongOverviewPage(this.song, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, right: 20, left: 20),
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                song.name,
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                child: Text(
                  song.artist,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Text(song.album, style: Theme.of(context).textTheme.titleLarge),
              Padding(
                padding: const EdgeInsets.only(
                  top: 200,
                ), // TESTESTESTESTESTESTESTESTESTE
                child: SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
