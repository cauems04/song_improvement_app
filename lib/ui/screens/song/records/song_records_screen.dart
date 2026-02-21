import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/data/model/selected_song_provider.dart';
import 'package:guitar_song_improvement/themes/spacing.dart';
import 'package:guitar_song_improvement/ui/screens/song/records/widgets/record_card.dart';
import 'package:guitar_song_improvement/ui/screens/song/widgets/listAppBar.dart';
import 'package:provider/provider.dart';

class SongRecordsScreen extends StatelessWidget {
  //Turn into a statefulidget
  final GlobalKey recordListKey = GlobalKey<AnimatedListState>();

  SongRecordsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SafeArea(
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.surface,
                Theme.of(context).colorScheme.onSurface,
                Theme.of(context).colorScheme.surface,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: CustomScrollView(
            slivers: [
              if (Provider.of<SelectedSongProvider>(context).records != null &&
                  Provider.of<SelectedSongProvider>(
                    context,
                  ).records!.isNotEmpty)
                Listappbar(listType: SongListTypes.recordings),
              Consumer<SelectedSongProvider>(
                builder: (context, data, child) {
                  if (!data.isLoaded) {
                    return SliverToBoxAdapter(
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  if (data.records!.isEmpty) {
                    return SliverToBoxAdapter(
                      child: Center(child: Text("No records found. Add one!")),
                    );
                  }

                  final List<RecordCard> recordCards = data.records!
                      .map((record) => RecordCard(record))
                      .toList();

                  return SliverPadding(
                    padding: const EdgeInsets.fromLTRB(
                      Spacing.md,
                      Spacing.md,
                      Spacing.md,
                      80,
                    ),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        return Padding(
                          padding: (index < data.records!.length - 1)
                              ? const EdgeInsets.only(bottom: Spacing.md)
                              : const EdgeInsets.all(0),
                          child: recordCards[index],
                        );
                      }, childCount: recordCards.length),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
