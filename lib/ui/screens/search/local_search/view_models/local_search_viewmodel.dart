import 'package:flutter/material.dart';

enum FilterOptions { songs, albums, artists, favorites }

class LocalSearchViewmodel {
  final ValueNotifier<FilterOptions?> currentFilter = ValueNotifier(
    FilterOptions.songs,
  );

  void changeFilter(FilterOptions filter) {
    if (currentFilter.value == filter) {
      return;
    }

    currentFilter.value = filter;
  }
}
