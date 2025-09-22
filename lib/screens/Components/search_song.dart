import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/screens/search_page.dart';
import 'package:guitar_song_improvement/themes/spacing.dart';

class SearchSong extends StatelessWidget {
  final String hint;

  const SearchSong(this.hint, {super.key});

  @override
  Widget build(BuildContext context) {
    final double spacingMd = Spacing.md;

    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: spacingMd, right: spacingMd),
        child: TextField(
          textAlignVertical: TextAlignVertical.center,
          style: Theme.of(
            context,
          ).textTheme.bodyLarge!.copyWith(color: Colors.black),
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search, size: 20, color: Colors.black),
            hintText: hint,
            border: InputBorder.none,
            hintStyle: Theme.of(
              context,
            ).textTheme.bodyLarge!.copyWith(color: Colors.black),
            isDense: true,
          ),
          onSubmitted: (value) {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (context) => SearchPage()));
          },
        ),
      ),
    );
  }
}
