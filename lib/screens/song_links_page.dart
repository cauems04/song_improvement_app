import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/model/link.dart';
import 'package:guitar_song_improvement/model/selected_song_provider.dart';
import 'package:guitar_song_improvement/screens/components/link_card.dart';
import 'package:provider/provider.dart';

class SongLinksPage extends StatelessWidget {
  //Turn into a statefulidget

  const SongLinksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, right: 20, left: 20),
      child: Consumer<SelectedSongProvider>(
        builder: (context, data, child) {
          if (!data.isLoaded) return CircularProgressIndicator();

          if (data.links!.isEmpty) return Text("No links found. Add one!");

          List<LinkCard> linkWidgets = [];

          for (Link link in data.links!) {
            linkWidgets.add(LinkCard(link));
          }

          return ListView.builder(
            shrinkWrap: true,
            itemCount: linkWidgets.length,
            itemBuilder: (context, index) => linkWidgets[index],
          );
        },
      ),
    );
  }
}
