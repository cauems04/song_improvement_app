import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/data/model/selected_song_provider.dart';
import 'package:guitar_song_improvement/themes/spacing.dart';
import 'package:guitar_song_improvement/ui/screens/song/records/widgets/record_card.dart';
import 'package:provider/provider.dart';

class SongRecordsScreen extends StatelessWidget {
  //Turn into a statefulidget
  final GlobalKey recordListKey = GlobalKey<AnimatedListState>();

  SongRecordsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.surface,
              Theme.of(context).colorScheme.onSurface,
              Theme.of(context).colorScheme.surface,
            ],
            begin: AlignmentGeometry.topLeft,
            end: AlignmentGeometry.bottomRight,
          ),
        ),
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

              if (data.records!.isEmpty) {
                return Text("No records found. Add one!");
              }

              final List<RecordCard> recordCards = data.records!
                  .map((record) => RecordCard(record))
                  .toList();

              return ListView.separated(
                separatorBuilder: (context, index) =>
                    SizedBox(height: Spacing.md),
                itemCount: recordCards.length,
                itemBuilder: (context, index) {
                  return recordCards[index];
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
