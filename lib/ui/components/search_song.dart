import 'package:flutter/material.dart';
import 'package:guitar_song_improvement/themes/spacing.dart';

class SearchSong extends StatefulWidget {
  final String hint;
  final String? search;
  final Function(String) onSearch;
  final Function(String)? onChanged;

  const SearchSong({
    super.key,
    required this.hint,
    this.search,
    required this.onSearch,
    this.onChanged,
  });

  @override
  State<SearchSong> createState() => _SearchSongState();
}

class _SearchSongState extends State<SearchSong> {
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController(
      text: (widget.search != null) ? widget.search : "",
    );
  }

  @override
  Widget build(BuildContext context) {
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
            hintText: widget.hint,
            border: InputBorder.none,
            hintStyle: Theme.of(
              context,
            ).textTheme.bodyLarge!.copyWith(color: Colors.black),
            isDense: true,
          ),
          onChanged: (value) => widget.onChanged?.call(value),
          onSubmitted: (value) => widget.onSearch(value),
        ),
      ),
    );
  }
}
