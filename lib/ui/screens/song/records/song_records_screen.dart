import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/data/model/selected_song_provider.dart';
import 'package:guitar_song_improvement/ui/widgets/link_card.dart';
import 'package:provider/provider.dart';

class SongRecordsScreen extends StatelessWidget {
  //Turn into a statefulidget
  final GlobalKey recordListKey = GlobalKey<AnimatedListState>();

  SongRecordsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 40, right: 20, left: 20),
        child: Consumer<SelectedSongProvider>(
          builder: (context, data, child) {
            if (!data.isLoaded) return CircularProgressIndicator();

            if (data.records!.isEmpty) {
              return Text("No records found. Add one!");
            }

            return Column(
              children: data.records!
                  .map((record) => Text(record.name))
                  .toList(),
            );
          },
        ),
      ),
    );
  }
}
