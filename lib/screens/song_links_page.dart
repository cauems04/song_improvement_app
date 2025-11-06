import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/model/link.dart';
import 'package:guitar_song_improvement/screens/components/link_card.dart';

class SongLinksPage extends StatelessWidget {
  //Turn into a statefulidget
  final Future<List<Link>> links;

  const SongLinksPage(this.links, {super.key});

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
              child = Center(child: Text("No links found. Add one"));
              break;
            case ConnectionState.done:
              List<LinkCard> linkWidgets = [];

              if (snapshot.data == null || snapshot.data!.isEmpty) {
                print(
                  "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAHHHHHH",
                );
                child = Center(child: Text("No link found. Add one"));
                break;
              }

              for (Link link in snapshot.data!) {
                linkWidgets.add(LinkCard(link));
              }

              child = ListView.builder(
                shrinkWrap: true,
                itemCount: linkWidgets.length,
                itemBuilder: (context, index) {
                  return linkWidgets[index];
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
