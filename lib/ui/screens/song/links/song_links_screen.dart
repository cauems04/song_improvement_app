import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/model/selected_song_provider.dart';
import 'package:guitar_song_improvement/ui/widgets/link_card.dart';
import 'package:provider/provider.dart';

class SongLinksScreen extends StatelessWidget {
  //Turn into a statefulidget
  final GlobalKey linkListKey = GlobalKey<AnimatedListState>();

  SongLinksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 40, right: 20, left: 20),
        child: Consumer<SelectedSongProvider>(
          builder: (context, data, child) {
            if (!data.isLoaded) return CircularProgressIndicator();

            if (data.links!.isEmpty) return Text("No links found. Add one!");

            return AnimatedList(
              key: linkListKey,
              shrinkWrap: true,
              initialItemCount: data.links!.length,
              itemBuilder: (context, index, animation) => LinkCard(
                data.links![index],
                listIndex: index,
                removeAnimation: animation,
              ),
            );
          },
        ),
      ),
    );
  }
}
