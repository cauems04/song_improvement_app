import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/controller/link_controller.dart';
import 'package:guitar_song_improvement/model/link.dart';
import 'package:guitar_song_improvement/model/song.dart';
import 'package:guitar_song_improvement/screens/components/link_card.dart';

class SongLinksPage extends StatelessWidget {
  //Turn into a statefulidget
  final Song song; //Turn into a statefulidget
  late Future<List<Link>> //Turn into a statefulidget
  links; // Instead of loading this data here, load on the SongPage(), at the beggining, so that the user doesn't load this everytime and passing pages become smoother

  SongLinksPage(this.song, {super.key}) {
    links =
        getLinks(); // Instead of loading this data here, load on the SongPage(), at the beggining, so that the user doesn't load this everytime and passing pages become smoother
  }

  Future<List<Link>> getLinks() async {
    // Instead of loading this data here, load on the SongPage(), at the beggining, so that the user doesn't load this everytime and passing pages become smoother
    // Instead of loading this data here, load on the SongPage(), at the beggining, so that the user doesn't load this everytime and passing pages become smoother
    LinkController songController =
        LinkController(); // Instead of loading this data here, load on the SongPage(), at the beggining, so that the user doesn't load this everytime and passing pages become smoother
    return await songController.linksBySong(
      song.id!,
    ); // Instead of loading this data here, load on the SongPage(), at the beggining, so that the user doesn't load this everytime and passing pages become smoother
  } // Instead of loading this data here, load on the SongPage(), at the beggining, so that the user doesn't load this everytime and passing pages become smoother

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, right: 20, left: 20),
      child: FutureBuilder(
        future: links,
        builder: (context, snapshot) {
          Widget child;

          if (snapshot.hasError) {
            return Center(
              child: Text(
                "An error has shown up, try again later - ${snapshot.error}",
              ),
            );
          }

          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              child = Center(child: CircularProgressIndicator());
              break;
            case ConnectionState.none:
              child = Center(child: Text("No link found. Add one"));
              break;
            case ConnectionState.done:
              List<LinkCard> songWidgets = [];

              if (snapshot.data == null || snapshot.data!.isEmpty) {
                print(
                  "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAHHHHHH",
                );
                child = Center(child: Text("No link found. Add one"));
                break;
              }

              for (Link link in snapshot.data!) {
                songWidgets.add(LinkCard(link));
              }

              child = ListView.builder(
                itemCount: songWidgets.length,
                itemBuilder: (context, index) {
                  return songWidgets[index];
                },
              );
              break;
            default:
              child = Center(child: Text("******Standard Response******"));
              break;
          }
          return child;
        },
      ),
    );
  }
}
