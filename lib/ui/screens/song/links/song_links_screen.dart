import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/data/model/selected_song_provider.dart';
import 'package:guitar_song_improvement/themes/spacing.dart';
import 'package:guitar_song_improvement/ui/screens/song/links/widgets/link_card.dart';
import 'package:provider/provider.dart';

class SongLinksScreen extends StatelessWidget {
  //Turn into a statefulidget
  final GlobalKey linkListKey = GlobalKey<AnimatedListState>();

  SongLinksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          Spacing.md,
          Spacing.lg,
          Spacing.md,
          80,
        ),
        child: Consumer<SelectedSongProvider>(
          builder: (context, data, child) {
            if (!data.isLoaded) return CircularProgressIndicator();

            if (data.links!.isEmpty) return Text("No links found. Add one!");

            return AnimatedList(
              key: linkListKey,
              shrinkWrap: true,
              initialItemCount: data.links!.length,
              itemBuilder: (context, index, animation) {
                return Padding(
                  padding: (index < data.links!.length - 1)
                      ? const EdgeInsets.only(bottom: Spacing.md)
                      : const EdgeInsetsGeometry.all(0),
                  child: LinkCard(
                    data.links![index],
                    // listIndex: index,
                    // removeAnimation: ani mation,),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
