import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/screens/search_page.dart';
import 'package:guitar_song_improvement/themes/spacing.dart';

class SearchSong extends StatelessWidget {
  final String hint;

  final String? search;

  const SearchSong({super.key, required this.hint, this.search});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController(
      text: (search != null) ? search : "",
    );

    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: Spacing.md, right: Spacing.md),
        child: TextField(
          controller: searchController,
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
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => SearchPage(search: searchController.text),
              ),
            );
          },
        ),
      ),
    );
  }
}
